from database import Database
import uuid
import requests
import json


class Init(object):

    def __init__(self):
        # server
        self.serverId = 0
        self.serverName = ""
        # client
        self.clientId = ""
        self.clientName = ""
        # db
        self.db = ""
        self.dbHost = ""
        self.dbPort = ""
        self.dbUser = ""
        self.dbPass = ""
        # rabbitmq
        self.rmqHost = ""
        self.rmqPort = ""
        self.rmqTopic = ""
        self.rmqQueue = ""
        self.secretKey = ""
        self.regisRoute = "/registrasi_client"
        self.regisPort = 5000

    def databaseConnection(self):
        self.db = Database(
            host=self.dbHost,
            port=self.dbPort,
            user=self.dbUser,
            password=self.dbPass,
            databaseName=self.dbName
        )
        self.db.connect()

    def createTableInbox(self):
        self.db.execute("""
			CREATE TABLE `inbox` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`query` text,
				`type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
				`label` varchar(255) DEFAULT NULL,
				`table` varchar(255) DEFAULT NULL,
				`pk` bigint(20) DEFAULT NULL,
				`prev_pk` bigint(20) DEFAULT NULL,
				`timestamping` datetime DEFAULT NULL,
				`id_sender` int(11) DEFAULT NULL,
				`sender_name` varchar(255) DEFAULT NULL,
				`processed_on` datetime DEFAULT NULL,
				`is_process` tinyint(1) DEFAULT '0',
				`created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
				`udpated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
				PRIMARY KEY (`id`)
			)
			""")
        print("[+] Tabel Inbox => berhasil dibuat")

    def createTableOutbox(self):
        self.db.execute("""
			CREATE TABLE `outbox` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`query` text,
				`type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
				`label` varchar(255) DEFAULT NULL,
				`table` varchar(255) DEFAULT NULL,
				`pk` bigint(20) DEFAULT NULL,
				`prev_pk` bigint(20) DEFAULT NULL,
				`timestamping` datetime DEFAULT NULL,
				`processed_on` datetime DEFAULT NULL,
				`send_to` varchar(255) DEFAULT NULL,
				`is_sent` tinyint(1) DEFAULT '0',
				`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
				`updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
				PRIMARY KEY (`id`)
			)
			""")
        print("[+] Tabel Outbox berhasil dibuat")

    def createTableChangelog(self):
        self.db.execute("""
			CREATE TABLE `changelog` (
				`id` bigint(20) NOT NULL AUTO_INCREMENT,
				`query` text,
				`table` varchar(255) DEFAULT NULL,
				`pk` bigint(20) DEFAULT NULL,
				`prev_pk` bigint(20) DEFAULT NULL,
				`type` tinyint(4) DEFAULT NULL,
				`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
				`timestamping` datetime DEFAULT NULL,
				PRIMARY KEY (`id`)
			)
			""")
        print("[+] Tabel Changelog => berhasil dibuat")

    def createTableClients(self):
        self.db.execute("""
            CREATE TABLE `clients` (
                `id` int(11) NOT NULL AUTO_INCREMENT,
                `name` varchar(200) DEFAULT NULL,
                `topic` varchar(200) DEFAULT NULL,
                `queue` varchar(200) DEFAULT NULL,
                `created_at` datetime DEFAULT NULL,
                `updated_at` datetime DEFAULT NULL,
                PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1
        """)
        print("[+] Tabel Client => berhasil dibuat")

    def createTriggerChangeToOutbox(self):
        self.db.execute("DROP TRIGGER IF EXISTS changelog_to_outbox")
        query = """
			CREATE TRIGGER `changelog_to_outbox` AFTER INSERT ON `changelog`
			FOR EACH ROW BEGIN
				INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `timestamping`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, NEW.timestamping);
			END;
		"""
        self.db.execute(query)
        print("[+] Trigger Changelog ke Outbox berhasil dibuat")
        return True

    def addTimestampingColumn(self, tableName):
        self.db.execute(
            "ALTER TABLE %s ADD COLUMN `timestamping` DATETIME DEFAULT CURRENT_TIMESTAMP" % tableName)
        print("[+] %s : Kolom timestamping berhasil ditambahkan" % tableName)
    
    def addPkCorrectionColumn(self, tableName):
        self.db.execute(
            "ALTER TABLE %s ADD COLUMN `pk_correction` tinyint(1) DEFAULT '0'" % tableName)
        print("[+] %s : Kolom pk_correction berhasil ditambahkan" % tableName)

    def getTableName(self):
        res = self.db.select('SELECT table_name FROM information_schema.tables\
			WHERE table_schema = "%s" AND (table_name NOT IN ("changelog", "inbox", "outbox", "clients"))' % (self.dbName))
        return res

    def getColumnTable(self, tableName):
        res = self.db.select('SELECT COLUMN_NAME\
			FROM INFORMATION_SCHEMA.COLUMNS\
			WHERE TABLE_SCHEMA = "%s" AND TABLE_NAME = "%s" AND COLUMN_KEY <> "PRI"' % (self.dbName, tableName))
        return res

    def getPrimaryKeyName(self, tableName):
        res = self.db.select("SELECT key_column_usage.column_name\
			FROM information_schema.key_column_usage\
			WHERE table_schema = SCHEMA()\
			AND constraint_name = 'PRIMARY'\
			AND table_name = '%s'" % tableName)
        return res[0][0]

    def truncateTable(self, table):
        self.db.execute("TRUNCATE %s" % table)

    def dropTable(self, table):
        self.db.execute("DROP TABLE %s" % table)

    def dropTrigger(self, trigger):
        self.db.execute("DROP TRIGGER %s" % trigger)

    def createTriggerTable(self):
        print("[*] Memproses trigger untuk setiap tabel..")
        tables = self.getTableName()
        for table in tables:
            self.addTimestampingColumn(table[0])
            self.addPkCorrectionColumn(table[0])
            columns = self.getColumnTable(table[0])
            primaryKey = self.getPrimaryKeyName(table[0])
            self.createTriggerInsert(table[0], primaryKey, columns)
            self.createTriggerUpdate(table[0], primaryKey, columns)
            self.createTriggerDelete(table[0], primaryKey)

    def createTriggerInsert(self, tableName, primaryKey, columns):
        triggerName = "insert_"+tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = 'CREATE TRIGGER `%s` AFTER INSERT ON `%s` FOR EACH ROW\
			INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `timestamping`) VALUES' % (triggerName, tableName)
        queryValue = '(CONCAT("INSERT INTO %s (' % tableName
        columnsLength = len(columns)
        for i in range(columnsLength):
            queryValue += columns[i][0]
            if(i < columnsLength-1):
                queryValue += ', '
        queryValue += ') VALUES ('
        for i in range(columnsLength):
            queryValue += '\'", NEW.' + columns[i][0] + ',"\''
            if(i < columnsLength-1):
                queryValue += ', '
        queryValue += ')"), "%s", NEW.%s, NEW.%s, 1, NEW.timestamping);' % (
            tableName, primaryKey, primaryKey)
        self.db.execute(query+queryValue)
        print('[+] %s : Trigger "%s" => berhasil ditambahkan' %
              (tableName, triggerName))

    def createTriggerUpdate(self, tableName, primaryKey, columns):
        triggerName = "update_"+tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = 'CREATE TRIGGER `%s` AFTER UPDATE ON `%s` FOR EACH ROW BEGIN IF NEW.pk_correction = 0 AND OLD.pk_correction = 0 THEN\
			INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `timestamping`) VALUES' % (triggerName, tableName)
        queryValue = '(CONCAT("UPDATE %s SET ' % tableName
        columnsLength = len(columns)
        for i in range(columnsLength):
            queryValue += columns[i][0] + ' = ' + \
                '\'", NEW.' + columns[i][0] + ',"\''
            if(i < columnsLength-1):
                queryValue += ', '
        queryValue += ' WHERE %s = ' % (primaryKey)
        queryValue += '\'", NEW.' + primaryKey + ',"\''
        queryValue += '"), "%s", NEW.%s, OLD.%s, 2, NEW.timestamping); END IF; END;' % (
            tableName, primaryKey, primaryKey)
        self.db.execute(query+queryValue)
        print('[+] %s : Trigger "%s" => berhasil ditambahkan' %
              (tableName, triggerName))

    def createTriggerDelete(self, tableName, primaryKey):
        triggerName = "delete_"+tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = 'CREATE TRIGGER `%s` BEFORE DELETE ON `%s` \
			FOR EACH ROW INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`, `timestamping`)\
			VALUES (CONCAT("DELETE FROM %s WHERE %s=", OLD.%s), "%s", OLD.%s, OLD.%s, 3, OLD.timestamping);\
			' % (triggerName, tableName, tableName, primaryKey, primaryKey, tableName, primaryKey, primaryKey)
        self.db.execute(query)
        print('[+] %s : Trigger "%s" => berhasil ditambahkan' %
              (tableName, triggerName))

    def dropTriggerAuditLog(self):
        print("[*] Menghapus trigger audit log di setiap tabel..")
        tables = self.getTableName()
        for table in tables:
            triggerCaption = ["insert", "update", "delete"]
            for caption in triggerCaption:
                triggerName = "%s_%s" % (caption, table[0])
                self.dropTrigger(triggerName)
                print('[+] %s : Trigger "%s" => dihapus' %
                      (table[0], triggerName))

    def inputServer(self):

        self.serverName = input("[+] Nama Server\t\t: ")
        while(True):
            self.dbHost = input("[+] Host Database\t: ")
            self.dbPort = int(input("[+] Port Database\t: "))
            self.dbUser = input("[+] Username Database\t: ")
            self.dbPass = input("[+] Password Database\t: ")
            self.dbName = input("[+] Nama Database\t: ")
            try:
                print("[/] Mengecek koneksi ke database..")
                self.databaseConnection()
                print("[!] Database berhasil terkoneksi!")
                break
            except:
                print("[x] Koneksi database error. Silahkan input ulang")

        self.rmqHost = input("[+] RabbitMQ Host\t: ")
        self.secretKey = uuid.uuid4()
        file = open("env.py", "w")
        file.write('''# Database
DATABASE_HOST="%s"
DATABASE_PORT=%d
DATABASE_USER="%s"
DATABASE_PASSWORD="%s"
DATABASE_NAME="%s"
# RabbitMQ Server
RABBITMQ_SERVER_HOST="%s"
RABBITMQ_SERVER_PORT=""
# Database Sync Server
HOST_ID=0
HOST_NAME="%s"
HOST_QUEUE="server_queue"
SECRET_KEY="%s" 
#Tipe Host
IS_SERVER=1
            ''' % (self.dbHost, self.dbPort, self.dbUser, self.dbPass, self.dbName, self.rmqHost, self.serverName, self.secretKey))
        file.close()
        print("[!] Data berhasil disimpan ke file konfigurasi")
        print("[!] Server Secret Key : %s" % self.secretKey)
        self.createTableClients()
        self.createTableChangelog()
        self.createTableInbox()
        self.createTableOutbox()
        self.createTriggerChangeToOutbox()
        self.createTriggerTable()

    def inputClient(self):
        # database
        while(True):
            self.dbHost = input("[+] Host Database\t: ")
            self.dbPort = int(input("[+] Port Database\t: "))
            self.dbUser = input("[+] Username Database\t: ")
            self.dbPass = input("[+] Password Database\t: ")
            self.dbName = input("[+] Nama Database\t: ")
            try:
                print("[/] Mengecek koneksi ke database..")
                self.databaseConnection()
                print("[!] Database berhasil terkoneksi!")
                break
            except:
                print("[x] Koneksi database error. Silahkan input ulang")

        mode = int(input("Sinkroniasi [1/2 Arah]? : "))
        self.dropTable("clients")
        print("[/] Tabel clients => dihapus")
        if(mode == 1):
            self.truncateTable("inbox")
            print("[/] Tabel inbox => dikosongkan")
            self.dropTrigger("changelog_to_outbox")
            print("[/] Trigger changelog_to_outbox => dihapus")
            self.dropTable("changelog")
            print("[/] Tabel changelog => dihapus")
            self.dropTable("outbox")
            print("[/] Tabel outbox => dihapus")
            self.dropTriggerAuditLog()
        elif(mode == 2):
            self.truncateTable("inbox")
            print("[/] Tabel inbox => dikosongkan")
            self.truncateTable("outbox")
            print("[/] Tabel outbox => dikosongkan")
            self.truncateTable("changelog")
            print("[/] Tabel changelog => dikosongkan")

        # registrasi client
        while(True):
            self.clientName = input("[+] Nama Client\t\t: ")
            self.rmqHost = input("[+] Sync Server\t\t: ")
            self.secretKey = input("[+] Server Secret Key\t: ")
            url = 'http://%s:%d%s' % (self.rmqHost,
                                      self.regisPort, self.regisRoute)
            form = {'name': self.clientName, 'secretKey': self.secretKey}
            try:
                print("[/] Memproses registrasi ke server...")
                res = requests.post(url, form)
                res = json.loads(res.text)
                if(res["status"]):
                    print("[!] Registrasi client ke server berhasil!")
                    self.clientId = res["id"]
                    self.rmqQueue = res["queue"]
                    self.rmqTopic = res["topic"]
                    break
                else:
                    print("[x] Registrasi gagal : %s" % res["message"])
            except:
                print("[x] Terjadi gangguan. Coba beberapa saat lagi")

        file = open("env.py", "w")
        file.write('''# Database
DATABASE_HOST="%s"
DATABASE_PORT=%d
DATABASE_USER="%s"
DATABASE_PASSWORD="%s"
DATABASE_NAME="%s"
# RabbitMQ Server
RABBITMQ_SERVER_HOST="%s"
RABBITMQ_SERVER_PORT=""
#Database Sync Server
DB_SYNC_SERVER="%s"
DB_SYNC_PORT=""
#Database Sync Client
HOST_ID="%d"
HOST_NAME="%s"
HOST_TOPIC="%s"
HOST_QUEUE="%s"
#Tipe Host
IS_SERVER=0
            ''' % (self.dbHost, self.dbPort, self.dbUser, self.dbPass, self.dbName, self.rmqHost, self.rmqHost, self.clientId, self.clientName, self.rmqTopic, self.rmqQueue))
        file.close()
        print("[!] Data berhasil disimpan ke file konfigurasi")

    def run(self):
        print("=== INISIASI SERVICE SINKRONISASI DATABASE ===")
        tipe = int(input("Tipe Host [(1) Server / (2) Client] : "))
        if(tipe == 1):
            self.inputServer()
        elif(tipe == 2):
            self.inputClient()
        print("\n[!] Instaliasi service berhasil!")


init = Init()
init.run()
