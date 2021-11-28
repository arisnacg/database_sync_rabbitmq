from database import Database
import time
import pika
import json
import env


class Producer(object):
    def __init__(self, rabbitMQServer, rabbitMQPort, hostId, hostName, isServer):
        # property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.delayTime = 1
        self.isServer = isServer
        if isServer:
            self.exchange = "server_to_client"
        else:
            self.exchange = "client_to_server"
        self.exchangeType = "fanout"
        self.topic = ""
        self.hostId = hostId
        self.hostName = hostName
        # init method
        self.databaseConnection()
        self.decleareExchange()
        if self.isServer:
            self.f = open("time_sent_server.txt", "w+")
        else:
            self.f = open("time_sent_client.txt", "w+")

    def databaseConnection(self):
        self.db = Database(
            host=env.DATABASE_HOST,
            port=env.DATABASE_PORT,
            user=env.DATABASE_USER,
            password=env.DATABASE_PASSWORD,
            databaseName=env.DATABASE_NAME,
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

    def getOutbox(self):
        res = self.db.select(
            "SELECT `outbox_id`, `query`, `type`, `label`, `table`, `pk`, `prev_pk`, `uuid`, `processed_on`, `send_to`, `last_update` FROM outbox WHERE is_sent=0"
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
            "uuid": outbox[7],
            "last_update": outbox[10],
            "send_to": outbox[9],
            "id_sender": self.hostId,
            "sender_name": self.hostName,
            "processed_on": outbox[8],
        }
        self.channel.basic_publish(
            exchange=self.exchange, routing_key=self.topic, body=json.dumps(message)
        )
        if self.db.update("UPDATE outbox SET is_sent=1 WHERE outbox_id=%d" % outbox[0]):
            print("[OUTBOX ID : %d] SUCCESS : %s" % (outbox[0], outbox[1]))

    def getLabel(self, type):
        if type == 1:
            return "INSERT"

    def publish(self):
        self.rabbitMQConnect()
        while True:
            # select outbox
            for outbox in self.getOutbox():
                self.publishOutbox(outbox)
                self.f.write("%f\n" % time.time())
            # delay
            self.connection.sleep(self.delayTime)
            time.sleep(self.delayTime)

    def run(self):
        type = "Client"
        if self.isServer:
            type = "Server"
        print("[*] %s Producer Running..." % type)
        self.publish()


producer = Producer(
    rabbitMQServer=env.RABBITMQ_SERVER_HOST,
    rabbitMQPort=env.RABBITMQ_SERVER_PORT,
    hostId=env.HOST_ID,
    hostName=env.HOST_NAME,
    isServer=env.IS_SERVER,
)
producer.run()