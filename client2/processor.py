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
        res = self.db.select("SELECT `id`, `query`, `type`, `table`, `pk`, `timestamping`, `id_sender`, `priority`\
             FROM inbox WHERE is_process=0 ORDER BY priority")
        return res
    
    def executeQueryInbox(self, inbox):
        res = False
        if(inbox[2] == 1):
            res = self.queryInsert(inbox)
        elif(inbox[2] == 2):
            res = self.queryUpdate(inbox)
        return res

        
    def queryInsert(self, inbox):
        print("[*] Query insert => %s" % inbox[1])
        lastId = self.db.insert(inbox[1])
        if(lastId):
            print("[+] Query successfully executed")
            self.updateInboxProccess(inbox[0])
            return True
        else:
            print("[-] Query failed to exectued")
            return False
    
    def queryUpdate(self, inbox):
        print("[*] Query update => %s" % inbox[1])
        try:
            res = self.db.update(inbox[1])
            if(res):
                print("[+] Query successfully executed")
                self.updateInboxProccess(inbox[0])
                return True
        except Exception as e:
            priority = inbox[7] + 1
            self.db.update("UPDATE inbox SET priority=%d WHERE id=%d" %(priority, inbox[0]))
            print("[-] Query failed to exectued. Priority down to %d" %priority)
            return False
    
    def updateInboxProccess(self, id):
        self.db.insert("UPDATE inbox SET is_process=1 WHERE id=%d" % id)       
    
    def process(self):
        while(True):
            for inbox in self.getInbox():
                self.executeQueryInbox(inbox)
            time.sleep(self.delayTime)
    
    def run(self):
        print("[*] Client Processor Running...")
        self.process()


processor = Processor()
processor.run()