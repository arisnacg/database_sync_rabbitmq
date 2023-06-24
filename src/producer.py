#! /bin/python3

from database import Database
import time
import pika
import json
from os import getenv
from dotenv import load_dotenv

load_dotenv()


class Producer(object):
    def __init__(self, rabbitMQServer, rabbitMQPort, hostId, hostName, isServer):
        # property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.delayTime = 1
        self.isServer = isServer
        if isServer:
            self.exchange = "server_to_client"
            self.exchangeType = "topic"
        else:
            self.exchange = "client_to_server"
            self.exchangeType = "fanout"
        self.hostId = hostId
        self.hostName = hostName

        # init method
        self.databaseConnection()
        self.decleareExchange()
        if isServer:
            self.topic = self.getServerTopic()
        else:
            self.topic = ""

    def databaseConnection(self):
        self.db = Database(
            host=getenv("DATABASE_HOST"),
            port=getenv("DATABASE_PORT"),
            user=getenv("DATABASE_USER"),
            password=getenv("DATABASE_PASSWORD"),
            databaseName=getenv("DATABASE_NAME"),
        )
        self.db.connect()

    def rabbitMQConnect(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.rabbitMQServer)
        )
        self.channel = self.connection.channel()

    def rabbitMQClose(self):
        if self.connection.is_open:
            self.connection.close()

    def decleareExchange(self):
        self.rabbitMQConnect()
        self.channel.exchange_declare(
            exchange=self.exchange, exchange_type=self.exchangeType
        )
        self.rabbitMQClose()

    def getServerTopic(self):
        arrClientID = self.getClientIDs()
        clientStr = ".".join(map(str, arrClientID))
        topic = f".{clientStr}."
        return topic

    def getClientIDs(self):
        res = self.db.select("SELECT `client_id` FROM clients")
        arrClientID = []
        for client in res:
            arrClientID.append(client[0])
        return arrClientID

    def getOutbox(self):
        res = self.db.select(
            "SELECT `outbox_id`, `query`, `type`, `label`, `table`, `pk`, `prev_pk`, `processed_on`, `block_list` FROM outbox WHERE is_sent=0"
        )
        return res

    def publishOutbox(self, outbox):
        message = {
            "query": outbox[1],
            "type": outbox[2],
            "label": outbox[3],
            "table": outbox[4],
            "pk": outbox[5],
            "prev_pk": outbox[6],
            "processed_on": outbox[7],
            "id_sender": self.hostId,
            "sender_name": self.hostName,
        }
        routing_key = self.topic

        block_list = outbox[8]
        if block_list is not None and block_list != "":
            routing_key = routing_key.replace(block_list, "")

        self.channel.basic_publish(
            exchange=self.exchange, routing_key=routing_key, body=json.dumps(message)
        )
        if self.db.update("UPDATE outbox SET is_sent=1 WHERE outbox_id=%d" % outbox[0]):
            print(
                f"[ID:{outbox[0]}] {outbox[4]}:{outbox[5]} {outbox[3]} -> ({routing_key}) SUCCESS"
            )

    def publish(self):
        self.rabbitMQConnect()
        while True:
            # select outbox
            for outbox in self.getOutbox():
                self.publishOutbox(outbox)
            # delay
            self.connection.sleep(self.delayTime)
            time.sleep(self.delayTime)

    def run(self):
        try:
            host_type = "Client"
            if self.isServer:
                host_type = "Server"
            print("[*] Exchange: %s" % self.exchange)
            print("[*] %s Producer Running..." % host_type)
            self.publish()
        except KeyboardInterrupt:
            print("\nExit..")


producer = Producer(
    rabbitMQServer=getenv("RABBITMQ_SERVER_HOST"),
    rabbitMQPort=getenv("RABBITMQ_SERVER_PORT"),
    hostId=getenv("HOST_ID"),
    hostName=getenv("HOST_NAME"),
    isServer=int(getenv("IS_SERVER", 0)),
)
producer.run()
