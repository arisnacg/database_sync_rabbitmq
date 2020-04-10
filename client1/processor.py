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
        self.label = {
            "updatePrimaryKey": "UPDATE_PRIMARY_KEY"
        }
    
    #koneksi database
    ###########################################################################
    def databaseConnection(self):
        self.db = Database(
            host=env.DATABASE_HOST,
            port=env.DATABASE_PORT,
            user=env.DATABASE_USER,
            password=env.DATABASE_PASSWORD,
            databaseName=env.DATABASE_NAME
        )
        self.db.connect()
    
    #mengambil data dari inbox
    ###########################################################################
    def getInbox(self):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `timestamping`, `id_sender`, `priority`, `label`, `is_process`\
             FROM inbox WHERE is_process=0 AND label <> 'UPDATE_PRIMARY_KEY' ORDER BY priority")
        if(len(res) == 0):
            res = self.db.select("SELECT `id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `timestamping`, `id_sender`, `priority`, `label`, `is_process`\
             FROM inbox WHERE is_process=0 AND label <> 'UPDATE_PRIMARY_KEY' ORDER BY priority")
        return res
    
    #mengexcute query dari inbox
    ###########################################################################
    def executeQueryInbox(self, inbox):
        res = False
        if(inbox[2] == 1):
            res = self.queryInsert(inbox)
        elif(inbox[2] == 2):
            res = self.queryUpdate(inbox)
        return res

    #func query insert
    ###########################################################################
    def queryInsert(self, inbox):
        print("[*] INSERT => %s" % inbox[1])
        inboxUpdatePK = self.getUpdatePrimaryKey(inbox)
        if(inboxUpdatePK):
            print("[*] UPDATE PRIMARY KEY => FOUND")
            #cek apakah primary key sudah terpakai
            queryCek = "SELECT COUNT(*) FROM %s WHERE id=%d" % (inbox[3], inbox[4])
            print "[*] Checking for PK : %s" % queryCek
            res =  self.db.select()
            if(res[0] == 0):
                #excute insert
                lastId = self.db.insert(inbox[1])
                if(lastId):
                    print("[+] INSERT => Successfully executed")
                    self.updateInboxProccess(inbox[0])
                    #jika update pk berbeda
                    if(inboxUpdatePK[2] != inboxUpdatePK[3]):
                        res = self.db.update(inboxUpdatePK[1])
                        if(res):
                            print("[*] UPDATE PRIMARY KEY => Successfully executed")
                            self.updateInboxProccess(inboxUpdatePK[0])
                            return True
                        else:
                            print("[*] UPDATE PRIMARY KEY => Failed to executed : %s" % inboxUpdatePK[1])
                    else:
                        self.updateInboxProccess(inboxUpdatePK[0])
                else:
                    print("[-] INSERT => Failed to executed")
            else:
                print "[-] Primary key already used : %d (count: %d)" % (inbox[4], res[0])
        else:
            print("[*] UPDATE PRIMARY KEY => NOT FOUND")
        return False

    #fucn query update
    ###########################################################################
    def queryUpdate(self, inbox):
        #cek apakah sudah di process
        if(inbox[10]):
            return True
        #melanjutkan proses
        print("[*] Query update => %s" % inbox[1])
        label = inbox[9]
        #mengecek update pk sama
        if(label == self.label["updatePrimaryKey"] and inbox[4] == inbox[5]):
            self.updateInboxProccess(inbox[0])
            return True
        #execute update
        res = self.db.update(inbox[1])
        if(res):
            print("[+] Query successfully executed")
            self.updateInboxProccess(inbox[0])
            return True
        else:
            print("[-] Query failed to exectued")
            return False
    
    #update status diproses pada inbox
    ###########################################################################
    def updateInboxProccess(self, id):
        self.db.insert("UPDATE inbox SET is_process=1 WHERE id=%d" % id)    

    #mendapatkan query khusus update pk dari inbox
    ###########################################################################
    def getUpdatePrimaryKey(self, inbox):
        res = self.db.select("SELECT `id`, `query`, `pk`, `prev_pk` FROM inbox WHERE `table` = '%s' AND label = 'UPDATE_PRIMARY_KEY' AND pk=%d AND is_process = 0 ORDER BY id DESC" % inbox[4])
        if(len(res) > 0):
            return res[0]
        else:
            return False

    #func untuk menjalankan proccessor
    ###########################################################################
    def process(self):
        while(True):
            for inbox in self.getInbox():
                self.executeQueryInbox(inbox)
            time.sleep(self.delayTime)

    #func untuk menjalankan program
    ###########################################################################
    def run(self):
        print("[*] Client Processor Running...")
        self.process()


processor = Processor()
processor.run()