#! /bin/python3
import pika
import json
from os import getenv
from dotenv import load_dotenv
from database import Database

load_dotenv()


class Consumer(object):
    def __init__(self, rabbitMQServer, rabbitMQPort, hostId, hostName, queue, isServer):
        # property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.isServer = isServer
        if isServer:
            self.exchange = "client_to_server"
        else:
            self.exchange = "server_to_client"
        self.exchangeType = "fanout"
        self.hostId = hostId
        self.hostName = hostName
        self.queue = queue
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
        self.channel.queue_bind(exchange=self.exchange, queue=self.queue)

    def callback(self, ch, method, properties, body):
        body = json.loads(body)
        if not body["send_to"] or str(self.hostId) in body["send_to"].split(";"):
            print("[*] From %s => %s" % (body["sender_name"], body["query"]))
            res = self.db.select(
                'SELECT outbox_id FROM outbox WHERE `query`="%s" \
                AND `type`=%d AND `table`="%s" AND `uuid`="%s" AND `last_update`="%s"'
                % (
                    body["query"],
                    body["type"],
                    body["table"],
                    body["uuid"],
                    body["last_update"],
                )
            )
            if not len(res) > 0:
                if self.insertInbox(body):
                    print("[+] Query added to INBOX")
                    ch.basic_ack(delivery_tag=method.delivery_tag)
            else:
                print("[!] Query has been rejected")
                ch.basic_ack(delivery_tag=method.delivery_tag)

    def insertInbox(self, body):
        query = "INSERT INTO inbox(`query`, `table`, `label`, `pk`, `prev_pk`, `type`, `uuid`, `id_sender`, `sender_name`, `last_update`) "
        query += (
            "VALUES (\"%s\", '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')"
            % (
                body["query"],
                body["table"],
                body["label"],
                body["pk"],
                body["prev_pk"],
                body["type"],
                body["uuid"],
                body["id_sender"],
                body["sender_name"],
                body["last_update"],
            )
        )
        return self.db.insert(query)

    def run(self):
        try:
            host_type = "Client"
            if self.isServer:
                host_type = "Server"
            print("[*] %s Consumer Running..." % host_type)
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
    isServer=getenv("IS_SERVER"),
)
consumer.run()
