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
             FROM inbox WHERE is_process=0")
        return res
    
    def executeQueryInbox(self, inbox):
        res = False
        if(inbox[2] == 1):
            res = self.queryInsert(inbox)
        elif(inbox[2] == 2):
            res = self.queryUpdate(inbox)
        elif(inbox[2] == 3):
            res = self.queryDelete(inbox)
        return res

        
    def queryInsert(self, inbox):
        print("[*] Query insert => %s" % inbox[1])
        lastId = self.db.insert(inbox[1])
        if(lastId):
            print("[+] Query successfully exectued")
            pkName = self.getPrimaryKeyName(inbox[3])
            queryUpdate = "UPDATE %s SET %s=%d WHERE %s=%d" % (inbox[3], pkName, lastId, pkName, inbox[4])
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

    #fucn query update
    ###########################################################################
    def queryUpdate(self, inbox):
        #melanjutkan proses
        print("[*] Query update => %s" % inbox[1])
        res = self.db.update(inbox[1])
        print("[+] Query successfully executed")
        self.updateInboxProccess(inbox[0])
        return True

    def queryDelete(self, inbox):
        #melanjutkan proses
        print("[*] Query delete => %s" % inbox[1])
        res = self.db.delete(inbox[1])
        if(res):
            print("[+] Query successfully executed")
            self.updateInboxProccess(inbox[0])
            return True
        else:
            print("[-] Query failed to exectued")
            self.updateInboxProccessedOn(inbox[0])
            return False
    
    def updateInboxProccess(self, id):
        self.db.insert("UPDATE inbox SET is_process=1 WHERE id=%d" % id)

    def updateInboxProccessedOn(self, id):
        processedOn = time.strftime('%Y-%m-%d %H:%M:%S')
        self.db.update(
            "UPDATE inbox SET processed_on='%s' WHERE id=%d" % (processedOn, id))
        print("[*] UPDATE Processed On Time => %s" % processedOn)     

    #mendapatkan nama kolom primary key
    ###########################################################################
    def getPrimaryKeyName(self, tableName):
        res = self.db.select("SELECT key_column_usage.column_name\
            FROM information_schema.key_column_usage\
            WHERE table_schema = SCHEMA()\
            AND constraint_name = 'PRIMARY'\
            AND table_name = '%s'" % tableName)
        return res[0][0]
    
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