import os
import time
import pika
import json
import env
from database import Database


class Receiver(object):
    def __init__(self, rabbitMQServer, rabbitMQPort, hostId, hostName, queue):
        #property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.exchange = "server_to_client"
        self.exchangeType = "fanout"
        self.hostId = hostId
        self.hostName = hostName
        self.queue = queue
        #init method
        self.databaseConnection()
        self.rabbitMQConnection()
        self.decleareExchange()
        self.decleareQueue()
        self.binding()

    def databaseConnection(self):
        self.db = Database(
            host=env.DATABASE_HOST,
            port=env.DATABASE_PORT,
            user=env.DATABASE_USER,
            password=env.DATABASE_PASSWORD,
            databaseName=env.DATABASE_NAME
        )
        self.db.connect()
    
    def rabbitMQConnection(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.rabbitMQServer)
        )
        self.channel = self.connection.channel()
    
    def decleareExchange(self):
        self.channel.exchange_declare(
            exchange=self.exchange,
            exchange_type=self.exchangeType
        )
    
    def decleareQueue(self):
        self.channel.queue_declare(queue=self.queue, durable=True)
    
    def binding(self):
        self.channel.queue_bind(
            exchange=self.exchange, 
            queue=self.queue
        )
    
    def callback(self, ch, method, properties, body):
        body = json.loads(body)
        if(not body["send_to"] or str(self.hostId) in body["send_to"].split(";")):
            print("[*] From %s => %s" % (body["sender_name"], body["query"]))
            res = self.db.select("SELECT id FROM outbox WHERE `query`=\"%s\" \
                AND `type`=%d AND `table`=\"%s\" AND `timestamping`=\"%s\"" % (body["query"], body["type"], body["table"], body["timestamping"]))
            if(not len(res) > 0):
                if(self.insertInbox(body)):
                    print("[+] Query added to INBOX")
                    ch.basic_ack(delivery_tag=method.delivery_tag)
            else:
                print("[!] Query has been rejected")
                ch.basic_ack(delivery_tag=method.delivery_tag)
    
    def insertInbox(self, body):
        query = "INSERT INTO inbox(`query`, `table`, `label`, `pk`, `prev_pk`, `type`, `timestamping`, `id_sender`, `sender_name`) "
        query += "VALUES (\"%s\", '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % (
            body["query"], body["table"], body["label"], body["pk"], body["prev_pk"], body["type"], body["timestamping"], body["id_sender"], body["sender_name"]
        )
        return self.db.insert(query)
    
    def run(self):
        print("[*] Client Reciver Running...")
        self.channel.basic_consume(queue=self.queue, on_message_callback=self.callback)
        self.channel.start_consuming()


receiver = Receiver(
    rabbitMQServer=env.RABBITMQ_SERVER_HOST,
    rabbitMQPort=env.RABBITMQ_SERVER_PORT,
    hostId=env.HOST_ID,
    hostName=env.HOST_NAME,
    queue=env.HOST_QUEUE
)
receiver.run()