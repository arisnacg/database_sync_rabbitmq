import os
import time
import pika
import json
import env
from database import Database


class Processor(object):
    def __init__(self):
        self.loopCount = 0
        self.inboxCount = 0
        self.delayTime = 1
        self.databaseConnection()
        self.pkCorrectionStatus = False
        self.prevPK = {}
        self.label = {
            "updatePrimaryKey": "UPDATE_PRIMARY_KEY"
        }

    # koneksi database
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

    # mengambil data dari inbox
    ###########################################################################
    def getInbox(self):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `timestamping`, `id_sender`, `processed_on`, `label`, `is_process`\
             FROM inbox WHERE is_process=0 ORDER BY processed_on DESC")
        return res

    # mengambil data dari inbox
    ###########################################################################
    def getInboxById(self, id):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `timestamping`, `id_sender`, `processed_on`, `label`, `is_process`\
             FROM inbox WHERE id=%d" % id)
        return res[0]
    
     # menampilkan info
    ###########################################################################
    def printInfo(self, inbox):
        pkCorrection = "no"
        if(self.pkCorrectionStatus):
            pkCorrection = "yes"
        print("\n====================================================")
        print("[ID: %d] [Loop : %d] [Inbox: %d] [PK correction: %s]" % (inbox[0], self.loopCount, self.inboxCount, pkCorrection))
        print("----------------------------------------------------")

    # mengexcute query dari inbox
    ###########################################################################
    def executeQueryInbox(self, inbox):
        res = False
        # jika bertipe insert
        if(inbox[2] == 1):
            res = self.queryInsert(inbox)
        # jika bertipe update
        elif(inbox[2] == 2):
             # jika update memiliki label PRI
            if(inbox[9] == self.label["updatePrimaryKey"]):
                res = self.queryPrimaryKey(inbox)
            else:
                res = self.queryUpdate(inbox)
        # jika bertipe delete
        elif(inbox[2] == 3):
            res = self.queryDelete(inbox)
        return res

    # func query insert
    ###########################################################################
    def queryInsert(self, inbox):
        self.printInfo(inbox)
        print("[>] QUERY: INSERT\n%s" % inbox[1])
        # cek apakah primary key sudah terpakai
        pkName = self.getPrimaryKeyName(inbox[3])
        queryCek = "SELECT COUNT(*) FROM %s WHERE %s=%d" % (
            inbox[3], pkName, inbox[4])
        # print("[*] Checking for PK : %s" % queryCek)
        # self.db.count(queryCek)
        success = False
        while(not success):
            try:
                lastId = self.db.insert(inbox[1])
                success = True
            except:
                success = False
        if(lastId):
            print("[>] Successfully executed")
            self.updateInboxProccess(inbox[0])
            if(lastId != inbox[4]):
                
                print("[>] Primary key from Inbox: %d" % inbox[4])
                print("[>] Primary key from DB   : %d" % lastId)
                # membuat UPDATE PRIMARY KEY
                self.createUpdatePrimaryKey(inbox, lastId)
                self.updatePkCorrectionStatus()
        else:
            print("[>] Failed to executed")
        return False

    # fucn query update
    ###########################################################################
    def queryUpdate(self, inbox):
        self.printInfo(inbox)
        if(self.pkCorrectionStatus):
            print("[>] INBOX SKIPPED")
            return False
        # melanjutkan proses
        print("[*] Query update => %s" % inbox[1])
        label = inbox[9]
        # mengecek update pk sama
        if(label == self.label["updatePrimaryKey"]):
            print("[*] Query update is UPDATE PRIMARY KEY")
            try:
                prevPKUpdate = self.prevPK[inbox[3]]
            except:
                prevPKUpdate = 0
            print("PREV UPDATE KEY :")
            print(self.prevPK)
            if(inbox[5] == prevPKUpdate):
                inbox = self.getInboxById(inbox[0])
                self.prevPK[inbox[3]] = 0
                print("[*] UPDATE PREV PK INBOX => %d" % prevPKUpdate)
            if(inbox[4] != inbox[5]):
                print("[*] UPDATE PRIMARY KEY is different")
                # cek apakah primary key sudah terpakai
                pkName = self.getPrimaryKeyName(inbox[3])
                queryCek = "SELECT COUNT(*) FROM %s WHERE %s=%d" % (inbox[3], pkName, inbox[4])
                print("[*] Checking for PK : %s" % queryCek)
                res = self.db.count(queryCek)
                if(res[0] > 0):
                    targetSwapInbox = self.getUpdatePrimaryKeyForSwap(inbox)
                    if(targetSwapInbox):
                        return self.swapUpdatePrimaryKey(inbox, targetSwapInbox)
                    return False
                print("[*] UPDATE PRIMARY KEY is ready : %s" % inbox[1])
            else:
                self.updateInboxProccess(inbox[0])
                return True
        # execute update
        if(self.pkCorrectionStatus):
            return False
        res = self.db.update(inbox[1])
        # print(inbox[1])
        if(res):
            print("[+] Query successfully executed")
            self.updateInboxProccess(inbox[0])
            return True
        else:
            print("[-] Query failed to exectued : %s" % (inbox[1]))
            # self.updateInboxProccessedOn(inbox[0])
            return False

    # fucn query primary key
    ###########################################################################
    # 0 => id inbox
    # 1 => query
    # 2 => type
    # 3 => table
    # 4 => pk
    # 5 => previous pk
    def queryPrimaryKey(self, inbox):
        self.printInfo(inbox)
        inbox = self.getInboxById(inbox[0])
        print("[>] QUERY: PRI\n%s" % inbox[1])
        # jika prev_pk sama denga prev_pk update update sebelumnya
        if((inbox[4] == inbox[5])):
            # memperbarui inbox menggunakan id
            inbox = self.getInboxById(inbox[0])
            # update status dan datetime process
            self.updateInboxProccess(inbox[0])
            self.updateInboxProccessedOn(inbox[0])
            self.updatePkCorrectionStatus()
            print("[>] Previous PK is same! PK correction end")
            return True

        # jika pk dan prev_pk dari inbox berbeda
        elif(inbox[4] != inbox[5]):
            print("[>] Previous PK is different!")
            # print("[*] UPDATE PRIMARY KEY is different")
            # cek apakah primary key sudah terpakai
            pkName = self.getPrimaryKeyName(inbox[3])
                # find pesan PRI di tabel inbox dengan pk (next)
            targetSwapInbox = self.getUpdatePrimaryKeyForSwap(inbox)
            if(targetSwapInbox):
                print("[>] Target swap is found")
                # swap
                return self.swapUpdatePrimaryKey(inbox, targetSwapInbox)
            else:
                print("[>] Target swap is not found")
                print("[>] INBOX SKIPPED")
                return False

    # fucn query delete
    ###########################################################################
    def queryDelete(self, inbox):
        if(self.pkCorrectionStatus):
            return False
        # melanjutkan proses
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

    # mendapatkan query khusus update pk dari inbox (swapping)
    ###########################################################################
    def getUpdatePrimaryKeyForSwap(self, inbox):
        res = self.db.select("SELECT `id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `timestamping`, `id_sender`, `processed_on`, `label`, `is_process`\
         FROM inbox WHERE `table` = '%s' AND label = 'UPDATE_PRIMARY_KEY' AND prev_pk=%d AND is_process = 0 ORDER BY id DESC" % (inbox[3], inbox[4]))
        if(len(res) > 0):
            return res[0]
        else:
            return False

    # menurkar primary key
    ###########################################################################
    def swapUpdatePrimaryKey(self, inbox1, inbox2):
        print("[>] Swapping Primary Key")
        print("[>] INBOX 1 : [ PK: %d ] [ Prev PK: %d  ]" % (inbox1[4], inbox1[5]))
        print("[>] INBOX 2 : [ PK: %d ] [ Prev PK: %d  ]" % (inbox2[4], inbox2[5]))
        # mengambil query dari inbox
        queryUpdateInbox = inbox1[1]
        # mengambil nama kolom primary key dari inbox
        pkName = self.getPrimaryKeyName(inbox1[3])
        #toggle kolom pk correction
        self.updateColumnPKCorrection(inbox1[3], pkName, inbox1[5], 1)
        # mengupdate row di tabel tujuan menjadi 0
        query = "UPDATE %s SET %s = 0, pk_correction = 1 WHERE %s = %d" %(inbox1[3], pkName, pkName, inbox1[4])
        self.db.update(query)
        print(query)
        # mengupdate pk row di tabel menjadi pk dari inbox
        self.db.update(queryUpdateInbox)
        print(queryUpdateInbox)
        self.updateColumnPKCorrection(inbox1[3], pkName, inbox1[4], 0)
        # update flag sudah diproses
        self.updateInboxProccess(inbox1[0])
        # update datetime kapan diproses
        self.updateInboxProccessedOn(inbox1[0])
        print("[>] INBOX 1 successfuly proccessed")
        # mengupdate row yang tadinya 0 menjadi prev_pk dari inbox tadi
        self.db.update("UPDATE %s SET %s = %d, pk_correction = 0 WHERE %s = 0" %
                       (inbox1[3], pkName, inbox1[5], pkName))
        # membuat query baru untuk target swap inbox
        newQueryUpdate = "UPDATE %s SET %s = %d WHERE %s = %d" % (
            inbox1[3], pkName, inbox2[4], pkName, inbox1[5])
        # mengupdate query, prev_pk dari target swap inbox dengan yang baru
        query =  "UPDATE inbox SET query = '%s', prev_pk = %d WHERE id = %d" % (newQueryUpdate, inbox1[5], inbox2[0])
        self.db.update(query)
        # print(query)
        print("[>] INBOX 2 :  [ Prev PK: %d  ]" % (inbox1[5]))
        # menandai prev pk dari target swap inbox pada tabel yang tadi
        print("[>] Swapping proccess done")
        return True

    
    # menurkar primary key
    ###########################################################################
    def updateColumnPKCorrection(self, table, pkName, pk, value):
        query = "UPDATE %s SET pk_correction = %d WHERE %s = %d" % (table, value, pkName, pk)
        print(query)
        self.db.update(query)

    # update status diproses pada inbox
    ###########################################################################
    def updateInboxProccess(self, id):
        self.db.insert("UPDATE inbox SET is_process=1 WHERE id=%d" % id)

    # update waktu diproses pada inbox
    ###########################################################################
    def updateInboxProccessedOn(self, id):
        processedOn = time.strftime('%Y-%m-%d %H:%M:%S')
        self.db.update(
            "UPDATE inbox SET processed_on='%s' WHERE id=%d" % (processedOn, id))
        # print("[*] UPDATE Processed On Time => %s" % processedOn)

    # membuat inbox update primary key
    ###########################################################################
    def createUpdatePrimaryKey(self, inbox, lastId):
        pkName = self.getPrimaryKeyName(inbox[3])
        queryUpdate = "UPDATE %s SET %s=%d WHERE %s=%d" % (
            inbox[3], pkName, inbox[4], pkName, lastId)
        queryInbox = "INSERT INTO inbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`) \
        VALUES (\"%s\", '%s', '%d', '%s', %d, '%s')" % (
            queryUpdate, inbox[3], inbox[4], lastId, 2, "UPDATE_PRIMARY_KEY")
        lastId = self.db.insert(queryInbox)
        print("[>] Inbox PRI add to inbox: [ID : %d]" % lastId)
        # print("[*] UPDATE Primary Key is created automatically => %s" % queryUpdate)

    # mendapatkan query khusus update pk dari inbox
    ###########################################################################
    def getUpdatePrimaryKey(self, inbox):
        res = self.db.select(
            "SELECT `id`, `query`, `pk`, `prev_pk` FROM inbox WHERE `table` = '%s' AND label = 'UPDATE_PRIMARY_KEY' AND pk=%d AND is_process = 0 ORDER BY id DESC" % (inbox[3], inbox[4]))
        if(len(res) > 0):
            return res[0]
        else:
            return False

    # mendapatkan nama kolom primary key
    ###########################################################################
    def getPrimaryKeyName(self, tableName):
        res = self.db.select("SELECT key_column_usage.column_name\
        FROM information_schema.key_column_usage\
        WHERE table_schema = SCHEMA()\
        AND constraint_name = 'PRIMARY'\
        AND table_name = '%s'" % tableName)
        return res[0][0]

    # update pk correction status
    ###########################################################################
    def updatePkCorrectionStatus(self):
        res = self.db.count(
            "SELECT COUNT(*) FROM inbox WHERE type=2 AND label = 'UPDATE_PRIMARY_KEY' AND is_process=0")
        if(res[0] == 0):
            self.pkCorrectionStatus = False
        else:
            self.pkCorrectionStatus = True

    # func untuk menjalankan proccessor
    ###########################################################################
    def process(self):
        while(True):
            self.loopCount += 1
            inboxes = self.getInbox()
            self.inboxCount = len(inboxes)
            # print("[*] INBOX COUNT : %d" % len(inboxes))
            i = 1
            for inbox in inboxes:
                # print("[*] INBOX ID : %d" % inbox[0])
                self.executeQueryInbox(inbox)
                i += 1
            time.sleep(self.delayTime)

    # func untuk menjalankan program
    ###########################################################################
    def run(self):
        print("[*] Client Processor Running...")
        self.process()


processor = Processor()
processor.run()
