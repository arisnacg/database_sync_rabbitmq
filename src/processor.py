#! /bin/python3
from os import getenv
import time
from dotenv import load_dotenv
import sys
import re
from database import Database

load_dotenv()


class Processor(object):
    def __init__(self):
        self.isServer = int(getenv("IS_SERVER", 0))
        self.loopCount = 0
        self.inboxCount = 0
        self.delayTime = 1
        self.databaseConnection()
        self.pkCorrectionStatus = {}
        self.defaultBlocklist = self.getDefaultBlocklist()

    # koneksi database
    ###########################################################################
    def databaseConnection(self):
        self.db = Database(
            host=getenv("DATABASE_HOST"),
            port=getenv("DATABASE_PORT"),
            user=getenv("DATABASE_USER"),
            password=getenv("DATABASE_PASSWORD"),
            databaseName=getenv("DATABASE_NAME"),
        )
        self.db.connect()

    # mendapatkan ID client
    ###########################################################################
    def getDefaultBlocklist(self):
        if not self.isServer:
            return ""
        arrClientID = self.getClientIDs()
        clientStr = ".".join([str(clientID) for clientID in arrClientID])
        return f".{clientStr}"

    # mendapatkan ID client
    ###########################################################################
    def getClientIDs(self):
        res = self.db.select("SELECT `client_id` FROM clients")
        arrClientID = []
        for client in res:
            arrClientID.append(client[0])
        return arrClientID

    # mengambil data dari inbox
    ###########################################################################
    def getInbox(self):
        res = self.db.select(
            "SELECT `inbox_id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `id_sender`, `processed_on`, `label`, `is_process`\
             FROM inbox WHERE is_process=0"
        )
        return res

    # mengambil data dari inbox
    ###########################################################################
    def getInboxById(self, id):
        res = self.db.select(
            "SELECT `inbox_id`, `query`, `type`, `table`,  `pk`, `prev_pk`, `id_sender`, `processed_on`, `label`, `is_process`\
             FROM inbox WHERE inbox_id=%d"
            % id
        )
        return res[0]

    # menampilkan info
    ###########################################################################
    def printInfo(self, event, success=True, optionalLog=""):
        log = f"[ID:{event['inbox_id']}] {event['label']} -> {event['table']}:{event['pk']}"
        if optionalLog != "":
            log += f" .. {optionalLog}"
        if success:
            log += " .. SUCCESS"
        else:
            log += " .. FAILED"
        print(log)

    # mengexcute query dari inbox
    ###########################################################################
    def executeQueryInbox(self, event):
        res = False
        # jika bertipe INS
        if event["type"] == 1:
            if self.isServer:
                res = self.queryInsertServer(event)
            else:
                res = self.queryInsertClient(event)
        # jika bertipe PRI
        elif event["type"] == 4:
            if not self.isServer:
                res = self.updatePrimaryKeyClient(event)
        # jika bertipe UPD
        elif event["type"] == 2:
            if self.isServer:
                res = self.queryUpdateServer(event)
            else:
                res = self.queryUpdateClient(event)
        # jika bertipe DEL
        elif event["type"] == 3:
            if self.isServer:
                res = self.queryDeleteServer(event)
            else:
                res = self.queryDeleteClient(event)
        return res

    # func update primary key
    ###########################################################################
    def updatePrimaryKeyClient(self, event):
        pkName = self.getPrimaryKeyName(event["table"])

        optionalLog = ""
        queryUpdate = ""
        success = False

        # mengecek duplicate primary key
        queryCount = f"SELECT COUNT({pkName}) FROM {event['table']} WHERE {pkName} = {event['pk']}"
        isPKExist = self.db.count(queryCount)
        if not isPKExist:
            queryUpdate = f"UPDATE {event['table']} SET {pkName} = {event['pk']} WHERE {pkName} = -{event['prev_pk']}"
            self.db.update(queryUpdate)
            optionalLog = f"(pk: -{event['pk']} -> {event['pk']})"
            try:
                self.db.update(queryUpdate)
                self.updateInboxProccess(event["inbox_id"])
                success = True
            except:
                success = False
            self.printInfo(event, success, optionalLog)
            return success

    # func query insert for server
    ###########################################################################
    def queryInsertServer(self, event):
        # cek apakah primary key sudah terpakai
        queryInsert = event["query"]
        optionalLog = ""
        lastId = None
        success = False

        try:
            self.updateInboxProccess(event["inbox_id"])
            lastId = self.db.insert(queryInsert)
            success = True
        except:
            success = False

        if lastId != event["pk"]:
            queryUpdate = ""
            blocklist = self.defaultBlocklist.replace(f".{event['id_sender']}", "")
            if blocklist == "":
                blocklist = "NULL"
            else:
                blocklist = f"'{blocklist}'"
            queryOutbox = f"INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`, `block_list`) \
                VALUES (\"{queryUpdate}\", '{event['table']}', '{lastId}', '{event['pk']}', '4', 'PRI', {blocklist})"
            self.db.insert(queryOutbox)
            optionalLog = f"(pk: {event['pk']} -> {lastId})"
        self.printInfo(event, success, optionalLog)
        return success

    # func query insert for client
    ###########################################################################
    def queryInsertClient(self, event):
        pkName = self.getPrimaryKeyName(event["table"])

        queryInsert = event["query"]
        optionalLog = ""
        success = False

        # mengecek duplicate primary key
        queryCount = f"SELECT COUNT({pkName}) FROM {event['table']} WHERE {pkName} = {event['pk']}"
        isPKExist = self.db.count(queryCount)
        if isPKExist:
            queryInsert = self.modifyInsertQueryForClient(
                queryInsert, event["table"], pkName, event["pk"]
            )
            queryUpdate = f"UPDATE {event['table']} SET {pkName} = -{event['pk']} WHERE {pkName} = {event['pk']}"
            self.db.update(queryUpdate)
            optionalLog = f"(pk: {event['pk']} -> -{event['pk']})"

        try:
            self.updateInboxProccess(event["inbox_id"])
            self.db.insert(queryInsert)
            success = True
        except:
            success = False

        self.printInfo(event, success, optionalLog)
        return success

    # func to get pk corection status
    ###########################################################################
    def getPkCorrectionStatus(self, table, pkName):
        minusPKCount = self.db.count(
            f"SELECT COUNT(pkName) FROM {table} WHERE {pkName} < 0"
        )
        if minusPKCount > 0:
            return True
        return False

    # fucn query update for client
    ###########################################################################
    def queryUpdateClient(self, event):
        pkName = self.getPrimaryKeyName(event["table"])
        # mengecek pk correction status
        if self.getPkCorrectionStatus(event['table'], pkName):
            return False
        success = self.db.update(event['query'])
        self.updateInboxProccess(event['inbox_id'])
        self.printInfo(event, success)
        return True

    # fucn query update for server
    ###########################################################################
    def queryUpdateServer(self, event):
        success = self.db.update(event['query'])
        self.updateInboxProccess(event["inbox_id"])
        self.printInfo(event, success)
        return True

    # fucn query delete for client
    ###########################################################################
    def queryDeleteClient(self, event):
        pkName = self.getPrimaryKeyName(event["table"])
        # mengecek pk correction status
        if self.getPkCorrectionStatus(event['table'], pkName):
            return False
        success = self.db.delete(event['query'])
        self.updateInboxProccess(event['inbox_id'])
        self.printInfo(event, success)
        return True

    # fucn query delete for server
    ###########################################################################
    def queryDeleteServer(self, event):
        success = self.db.update(event['query'])
        self.updateInboxProccess(event["inbox_id"])
        self.printInfo(event, success)
        return True


    def modifyInsertQueryForClient(self, query, tableName, pkName, pk):
        # menambah kolom primary key
        added_string = f"{pkName}, "
        word_to_match = f"{tableName} ("
        regex_pattern = re.escape(word_to_match)
        query = re.sub(regex_pattern, r"\g<0>" + added_string, query)

        # menambah value primary key
        added_string = f"'{pk}', "
        word_to_match = "VALUES ("
        regex_pattern = re.escape(word_to_match)
        query = re.sub(regex_pattern, r"\g<0>" + added_string, query)

        return query



    # update status diproses pada inbox
    ###########################################################################
    def updateInboxProccess(self, id):
        processedOn = time.strftime("%Y-%m-%d %H:%M:%S")
        self.db.insert(
            f"UPDATE inbox SET is_process = 1, processed_on = '{processedOn}' WHERE inbox_id={id}"
        )

    # mendapatkan nama kolom primary key
    ###########################################################################
    def getPrimaryKeyName(self, tableName):
        res = self.db.select(
            "SELECT key_column_usage.column_name\
        FROM information_schema.key_column_usage\
        WHERE table_schema = SCHEMA()\
        AND constraint_name = 'PRIMARY'\
        AND table_name = '%s'"
            % tableName
        )
        return res[0][0]

    # func untuk menjalankan proccessor
    ###########################################################################
    def process(self):
        while True:
            self.loopCount += 1
            inboxes = self.getInbox()
            # self.inboxCount = len(inboxes)
            # print("[*] Inbox Count : %d" % len(inboxes))
            for inbox in inboxes:
                event = {
                    "inbox_id": inbox[0],
                    "query": inbox[1],
                    "type": inbox[2],
                    "table": inbox[3],
                    "pk": inbox[4],
                    "prev_pk": inbox[5],
                    "id_sender": inbox[6],
                    "processed_on": inbox[7],
                    "label": inbox[8],
                    "is_process": inbox[9],
                }
                self.executeQueryInbox(event)
            time.sleep(self.delayTime)

    # func untuk menjalankan program
    ###########################################################################
    def run(self):
        try:
            type = "Client"
            if self.isServer:
                type = "Server"
            print("[*] %s Processor Running..." % type)
            self.process()
        except KeyboardInterrupt:
            print("\nExit..")


processor = Processor()
processor.run()
