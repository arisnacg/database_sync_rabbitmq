#! /bin/python3
import pika
import json
from os import getenv
from dotenv import load_dotenv
from database import Database

load_dotenv()


class Consumer(object):
    def __init__(
        self, rabbitMQServer, rabbitMQPort, hostId, hostName, queue, topic, isServer
    ):
        # property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.isServer = isServer
        if isServer:
            self.exchange = "client_to_server"
            self.exchangeType = "fanout"
        else:
            self.exchange = "server_to_client"
            self.exchangeType = "topic"
        self.hostId = hostId
        self.hostName = hostName
        self.queue = queue
        self.topic = topic
        # init method
        self.databaseConnection()
        self.rabbitMQConnection()
        self.decleareExchange()
        self.decleareQueue()
        self.binding()

    def databaseConnection(self):
        self.db = Database(
            host=getenv("DATABASE_HOST"),
            port=getenv("DATABASE_PORT"),
            user=getenv("DATABASE_USER"),
            password=getenv("DATABASE_PASSWORD"),
            databaseName=getenv("DATABASE_NAME"),
        )
        self.db.connect()

    def rabbitMQConnection(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.rabbitMQServer)
        )
        self.channel = self.connection.channel()

    def decleareExchange(self):
        self.channel.exchange_declare(
            exchange=self.exchange, exchange_type=self.exchangeType
        )

    def decleareQueue(self):
        self.channel.queue_declare(queue=self.queue, durable=True)

    def binding(self):
        self.channel.queue_bind(
            exchange=self.exchange, queue=self.queue, routing_key=self.topic
        )

    def callback(self, ch, method, properties, body):
        body = json.loads(body)
        if self.insertInbox(body):
            ch.basic_ack(delivery_tag=method.delivery_tag)

    def insertInbox(self, body):
        query = "INSERT INTO inbox(`query`, `table`, `label`, `pk`, `prev_pk`, `type`, `id_sender`) "
        query += f"VALUES (\"{body['query']}\", '{body['table']}', '{body['label']}', '{body['pk']}', '{body['prev_pk']}', '{body['type']}', '{body['id_sender']}')"
        lastid = self.db.insert(query)
        print(
            f"[ID:{lastid}] {body['table']}:{body['pk']} {body['label']} <- SERVER ({self.topic})"
        )
        return lastid

    def run(self):
        try:
            host_type = "Client"
            if self.isServer:
                host_type = "Server"
            print("[*] %s Consumer Listening... (topic: %s)" % (host_type, self.topic))
            self.channel.basic_consume(
                queue=self.queue, on_message_callback=self.callback
            )
            self.channel.start_consuming()
        except KeyboardInterrupt:
            print("\nExit..")


consumer = Consumer(
    rabbitMQServer=getenv("RABBITMQ_SERVER_HOST"),
    rabbitMQPort=getenv("RABBITMQ_SERVER_PORT"),
    hostId=getenv("HOST_ID"),
    hostName=getenv("HOST_NAME"),
    queue=getenv("HOST_QUEUE"),
    topic=getenv("HOST_TOPIC"),
    isServer=int(getenv("IS_SERVER", 0)),
)
consumer.run()
