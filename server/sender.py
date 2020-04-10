from database import Database
import time
import pika
import json
import env

class Sender(object):
    def __init__(self, rabbitMQServer, rabbitMQPort, hostId, hostName):
        #property
        self.rabbitMQServer = rabbitMQServer
        self.rabbitMQPort = rabbitMQPort
        self.delayTime = 1
        self.exchange = "server_to_client"
        self.exchangeType = "fanout"
        self.topic = ""
        self.hostId = hostId
        self.hostName = hostName
        #init method
        self.databaseConnection()
        self.decleareExchange()

    def databaseConnection(self):
        self.db = Database(
            host=env.DATABASE_HOST,
            port=env.DATABASE_PORT,
            user=env.DATABASE_USER,
            password=env.DATABASE_PASSWORD,
            databaseName=env.DATABASE_NAME
        )
        self.db.connect()
    
    def rabbitMQConnect(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.rabbitMQServer)
        )
        self.channel = self.connection.channel()
    
    def rabbitMQClose(self):
        if self.connection.is_open :
            self.connection.close()
    
    def decleareExchange(self):
        self.rabbitMQConnect()
        self.channel.exchange_declare(
            exchange=self.exchange,
            exchange_type=self.exchangeType
        )
        self.rabbitMQClose()
    
    def getOutbox(self):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`, `pk`, `prev_pk`, `timestamping`, `send_to`, `label` FROM outbox WHERE is_sent=0")
        return res
    
    def publishOutbox(self, outbox):
        message = {
            "query": outbox[1],
            "type": outbox[2],
            "table": outbox[3],
            "pk": outbox[4],
            "prev_pk": outbox[5],
            "timestamping": outbox[6].strftime("%Y-%m-%d %H:%M:%S"),
            "id_sender": self.hostId,
            "sender_name": self.hostName,
            "send_to": outbox[7],
            "label": outbox[8]
        }
        self.channel.basic_publish(
            exchange=self.exchange,
            routing_key=self.topic,
            body=json.dumps(message)
        )
        if(self.db.update("UPDATE outbox SET is_sent=1 WHERE id=%d" % outbox[0])):
            print("[OUTBOX ID : %d] SUCCESS : %s" % (outbox[0], outbox[1]))
    
    def publish(self):
        self.rabbitMQConnect()
        while(True):
            #select outbox
            for outbox in self.getOutbox():
              self.publishOutbox(outbox) 
            #delay
            self.connection.sleep(self.delayTime)
            time.sleep(self.delayTime)
    
    def run(self):
        print("[*] Server Sender Running...")
        self.publish()
        

sender = Sender(
    rabbitMQServer=env.RABBITMQ_SERVER_HOST,
    rabbitMQPort=env.RABBITMQ_SERVER_PORT,
    hostId=env.HOST_ID,
    hostName=env.HOST_NAME
)
sender.run()