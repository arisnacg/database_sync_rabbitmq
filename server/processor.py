import os
import time
import pika
import json
import env
from database import Database

class Processor(object):
    def __init__(self):
        self.delayTime = 1
        self.databaseConnection()
    
    def databaseConnection(self):
        self.db = Database(
            host=env.DATABASE_HOST,
            port=env.DATABASE_PORT,
            user=env.DATABASE_USER,
            password=env.DATABASE_PASSWORD,
            databaseName=env.DATABASE_NAME
        )
        self.db.connect()
    
    def getInbox(self):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`, `pk`, `timestamping`, `id_sender`\
             FROM inbox WHERE is_process=0 ORDER BY priority")
        return res
    
    def executeQueryInbox(self, inbox):
        res = False
        if(inbox[2] == 1):
            res = self.queryInsert(inbox)
        return res

        
    def queryInsert(self, inbox):
        print("[*] Query insert => %s" % inbox[1])
        lastId = self.db.insert(inbox[1])
        if(lastId):
            print("[+] Query successfully exectued")
            queryUpdate = "UPDATE %s SET id=%d WHERE id=%d" % (inbox[3], lastId, inbox[4])
            queryOutbox = "INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `timestamping`, `send_to`, `label`) \
                VALUES (\"%s\", '%s', '%d', '%s', '%s', '%s', '%s', '%s')" % (
                    queryUpdate, inbox[3], lastId, inbox[4], 2, inbox[5], inbox[6], "UPDATE_PRIMARY_KEY"
                )
            self.db.insert(queryOutbox)
            
            self.updateInboxProccess(inbox[0])
            return True
        else:
            print("[-] Query failed to exectued")
            return False
    
    def updateInboxProccess(self, id):
        self.db.insert("UPDATE inbox SET is_process=1 WHERE id=%d" % id)       
    
    def process(self):
        while(True):
            for inbox in self.getInbox():
                self.executeQueryInbox(inbox)
            time.sleep(self.delayTime)
    
    def run(self):
        print("[*] Server Processor Running...")
        self.process()


processor = Processor()
processor.run()