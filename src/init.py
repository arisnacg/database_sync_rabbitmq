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
            databaseName=self.dbName,
        )
        self.db.connect()

    def createTableInbox(self):
        self.db.execute(
            """
      CREATE TABLE `inbox` (
        `inbox_id` bigint(20) NOT NULL AUTO_INCREMENT,
        `query` text,
        `type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
        `label` varchar(255) DEFAULT NULL,
        `table` varchar(255) DEFAULT NULL,
        `pk` bigint(20) DEFAULT NULL,
        `prev_pk` bigint(20) DEFAULT NULL,
        `uuid` varchar(36) DEFAULT NULL,
                `last_update` double DEFAULT NULL,
        `id_sender` int(11) DEFAULT NULL,
        `sender_name` varchar(255) DEFAULT NULL,
        `processed_on` datetime DEFAULT NULL,
        `is_process` tinyint(1) DEFAULT '0',
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `udpated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`inbox_id`)
      )
      """
        )
        print("[+] Tabel Inbox => berhasil dibuat")

    def createTableOutbox(self):
        self.db.execute(
            """
      CREATE TABLE `outbox` (
        `outbox_id` bigint(20) NOT NULL AUTO_INCREMENT,
        `query` text,
        `type` smallint(6) DEFAULT NULL COMMENT '1 = insert, 2 = update, 3 = delete',
        `label` varchar(255) DEFAULT NULL,
        `table` varchar(255) DEFAULT NULL,
        `pk` bigint(20) DEFAULT NULL,
        `prev_pk` bigint(20) DEFAULT NULL,
        `processed_on` datetime DEFAULT NULL,
        `block_list` varchar(255) DEFAULT NULL,
        `is_sent` tinyint(1) DEFAULT '0',
        `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`outbox_id`)
      )
      """
        )
        print("[+] Tabel Outbox berhasil dibuat")

    def createTableChangelog(self):
        self.db.execute(
            """
      CREATE TABLE `changelog` (
        `changelog_id` bigint(20) NOT NULL AUTO_INCREMENT,
        `query` text,
        `table` varchar(255) DEFAULT NULL,
        `pk` bigint(20) DEFAULT NULL,
        `prev_pk` bigint(20) DEFAULT NULL,
        `type` tinyint(4) DEFAULT NULL,
        `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`changelog_id`)
      )
      """
        )
        print("[+] Tabel Changelog => berhasil dibuat")

    def createTableClients(self):
        self.db.execute(
            """
            CREATE TABLE `clients` (
                `client_id` int(11) NOT NULL AUTO_INCREMENT,
                `name` varchar(200) DEFAULT NULL,
                `topic` varchar(200) DEFAULT NULL,
                `queue` varchar(200) DEFAULT NULL,
                `created_at` datetime DEFAULT NULL,
                `updated_at` datetime DEFAULT NULL,
                PRIMARY KEY (`client_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1
        """
        )
        print("[+] Tabel Client => berhasil dibuat")

    def createTriggerChangeToOutbox(self):
        self.db.execute("DROP TRIGGER IF EXISTS changelog_to_outbox")
        query = f"""
    CREATE
        TRIGGER `changelog_to_outbox` AFTER INSERT ON `changelog` 
        FOR EACH ROW BEGIN
      DECLARE label VARCHAR(5) DEFAULT 'INS';
      DECLARE blocklist VARCHAR(100) DEFAULT NULL;
      DECLARE inbox_count INT DEFAULT 0;

      IF NEW.type = 2 THEN
          SET label = 'UPD';
      ELSEIF NEW.type = 3 THEN
          SET label = 'DEL';
      END IF;
      IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '{self.dbName}' AND TABLE_NAME = 'clients') THEN
        SELECT id_sender INTO blocklist FROM inbox WHERE `table` = NEW.table AND `type` = NEW.type AND `query` = NEW.query AND is_process = 1 ORDER BY created_at DESC LIMIT 1;
        IF blocklist IS NOT NULL THEN
          SET blocklist = CONCAT('.', blocklist);
        END IF;
      INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`, `block_list`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, label, blocklist);
      ELSE
        SELECT COUNT(inbox_id) INTO inbox_count FROM inbox WHERE `table` = NEW.table AND `type` = NEW.type AND `query` = NEW.query AND id_sender = 0;
		IF inbox_count = 0 THEN
			INSERT INTO outbox(`query`, `table`, `pk`, `prev_pk`, `type`, `label`, `block_list`) VALUES (NEW.query, NEW.table, NEW.pk, NEW.prev_pk, NEW.type, label, blocklist);
		END IF;
      END IF;
    END;"""
        self.db.execute(query)
        print("[+] Trigger Changelog ke Outbox berhasil dibuat")
        return True

    # def addUUIDColumn(self, tableName):
    #     self.db.execute("ALTER TABLE %s ADD COLUMN `uuid` VARCHAR(36)" % tableName)
    #     print("[+] %s : Kolom uuid berhasil ditambahkan" % tableName)

    def addLastUpdateColumn(self, tableName):
        self.db.execute("ALTER TABLE %s ADD COLUMN `last_update` DOUBLE" % tableName)
        print("[+] %s : Kolom last_update berhasil ditambahkan" % tableName)

    def addPkCorrectionColumn(self, tableName):
        self.db.execute(
            "ALTER TABLE %s ADD COLUMN `pk_correction` tinyint(1) DEFAULT '0'"
            % tableName
        )
        print("[+] %s : Kolom pk_correction berhasil ditambahkan" % tableName)

    def getTableName(self):
        res = self.db.select(
            'SELECT table_name FROM information_schema.tables\
      WHERE table_schema = "%s" AND (table_name NOT IN ("changelog", "inbox", "outbox", "clients"))'
            % (self.dbName)
        )
        return res

    def getColumnTable(self, tableName):
        res = self.db.select(
            'SELECT COLUMN_NAME\
      FROM INFORMATION_SCHEMA.COLUMNS\
      WHERE TABLE_SCHEMA = "%s" AND TABLE_NAME = "%s" AND COLUMN_KEY <> "PRI"'
            % (self.dbName, tableName)
        )
        return res

    def alterPrimaryKey(self, tableName, pkName):
        self.db.execute("SET SQL_MODE='ALLOW_INVALID_DATES'")
        query = f"ALTER TABLE {tableName} MODIFY COLUMN {pkName} BIGINT SIGNED"
        self.db.execute(query)

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
            # self.addUUIDColumn(table[0])
            # self.addLastUpdateColumn(table[0])
            # self.addPkCorrectionColumn(table[0])
            columns = self.getColumnTable(table[0])
            primaryKey = self.getPrimaryKeyName(table[0])
            self.alterPrimaryKey(table[0], primaryKey)
            # self.createTriggerBeforeInsert(table[0], primaryKey, columns)
            self.createTriggerAfterInsert(table[0], primaryKey, columns)
            # self.createTriggerBeforeUpdate(table[0], primaryKey, columns)
            self.createTriggerAfterUpdate(table[0], primaryKey, columns)
            self.createTriggerDelete(table[0], primaryKey)

    def createTriggerAfterInsert(self, tableName, primaryKey, columns):
        triggerName = "after_insert_" + tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = f"CREATE TRIGGER `{triggerName}` AFTER INSERT ON `{tableName}` FOR EACH ROW\
      INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`) VALUES"
        queryValue = f'(CONCAT("INSERT INTO {tableName} ('
        columnsLength = len(columns)
        for i in range(columnsLength):
            queryValue += columns[i][0]
            if i < columnsLength - 1:
                queryValue += ", "
        queryValue += ") VALUES ("
        for i in range(columnsLength):
            queryValue += "'\", NEW." + columns[i][0] + ",\"'"
            if i < columnsLength - 1:
                queryValue += ", "
        queryValue += f')"), "{tableName}", NEW.{primaryKey}, NEW.{primaryKey}, 1);'
        self.db.execute(query + queryValue)
        print(
            '[+] %s : Trigger "%s" => berhasil ditambahkan' % (tableName, triggerName)
        )

    def createTriggerBeforeInsert(self, tableName, primaryKey, columns):
        triggerName = "before_insert_" + tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = (
            "CREATE TRIGGER `%s` BEFORE INSERT ON `%s` FOR EACH ROW BEGIN IF NEW.uuid IS NULL THEN\
             SET NEW.uuid = UUID(); SET NEW.last_update = UNIX_TIMESTAMP(NOW(3)); END IF; END;"
            % (triggerName, tableName)
        )
        # print("query:")
        # print(query)
        self.db.execute(query)
        print(
            '[+] %s : Trigger "%s" => berhasil ditambahkan' % (tableName, triggerName)
        )

    def createTriggerAfterUpdate(self, tableName, primaryKey, columns):
        triggerName = "after_update_" + tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = f"CREATE TRIGGER `{triggerName}` AFTER UPDATE ON `{tableName}` FOR EACH ROW BEGIN IF NEW.{primaryKey} > 0 AND OLD.{primaryKey} > 0 THEN\
      INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`) VALUES"
        queryValue = f'(CONCAT("UPDATE {tableName} SET '
        columnsLength = len(columns)
        for i in range(columnsLength):
            queryValue += columns[i][0] + " = " + "'\", NEW." + columns[i][0] + ",\"'"
            if i < columnsLength - 1:
                queryValue += ", "
        queryValue += f" WHERE {primaryKey} = "
        queryValue += "'\", OLD." + primaryKey + ",\"'"
        queryValue += (
            f'"), "{tableName}", NEW.{primaryKey}, OLD.{primaryKey}, 2); END IF; END;'
        )
        self.db.execute(query + queryValue)
        print(
            '[+] %s : Trigger "%s" => berhasil ditambahkan' % (tableName, triggerName)
        )

    def createTriggerBeforeUpdate(self, tableName, primaryKey, columns):
        triggerName = "before_update_" + tableName
        self.db.execute("DROP TRIGGER IF EXISTS %s" % triggerName)
        query = f"CREATE TRIGGER `{triggerName}` BEFORE UPDATE ON `{tableName}` FOR EACH ROW BEGIN IF OLD.{primaryKey} > 0 OR NEW.{primaryKey} > 0 THEN\
             SET NEW.last_update = UNIX_TIMESTAMP(NOW(3)); END IF; END;"
        self.db.execute(query)
        print(
            '[+] %s : Trigger "%s" => berhasil ditambahkan' % (tableName, triggerName)
        )

    def createTriggerDelete(self, tableName, primaryKey):
        triggerName = "after_delete_" + tableName
        self.db.execute(f"DROP TRIGGER IF EXISTS {triggerName}")
        query = f'CREATE TRIGGER `{triggerName}` BEFORE DELETE ON `{tableName}` \
      FOR EACH ROW INSERT INTO changelog(`query`, `table`, `pk`, `prev_pk`, `type`)\
      VALUES (CONCAT("DELETE FROM {tableName} WHERE {primaryKey}=", OLD.{primaryKey}), "{tableName}", OLD.{primaryKey}, OLD.{primaryKey}, 3);\
      '
        self.db.execute(query)
        print(
            '[+] %s : Trigger "%s" => berhasil ditambahkan' % (tableName, triggerName)
        )

    def dropTriggerAuditLog(self):
        print("[*] Menghapus trigger audit log di setiap tabel..")
        tables = self.getTableName()
        for table in tables:
            triggerCaption = ["insert", "update", "delete"]
            for caption in triggerCaption:
                triggerName = "%s_%s" % (caption, table[0])
                self.dropTrigger(triggerName)
                print('[+] %s : Trigger "%s" => dihapus' % (table[0], triggerName))

    def writeServerConfigFile(self):
        data = "# Database\n"
        data += f"DATABASE_HOST={self.dbHost}\n"
        data += f"DATABASE_PORT={self.dbPort}\n"
        data += f"DATABASE_USER={self.dbUser}\n"
        data += f"DATABASE_PASSWORD={self.dbPass}\n"
        data += f"DATABASE_NAME={self.dbName}\n"
        data += "#RabbitMQ\n"
        data += f"RABBITMQ_SERVER_HOST={self.rmqHost}\n"
        data += f'RABBITMQ_SERVER_PORT=""\n'
        data += "#Database Sync\n"
        data += "IS_SERVER=1\n"
        data += f"HOST_ID=0\n"
        data += f"HOST_NAME={self.serverName}\n"
        data += f'HOST_QUEUE="server_queue"\n'
        data += f'SECRET_KEY="{self.secretKey}"\n'
        file = open(".env", "w")
        file.write(data)
        file.close()
        print("[!] Data berhasil disimpan ke file konfigurasi")
        print("[!] Server Secret Key : %s" % self.secretKey)

    def writeClientConfigFile(self):
        data = "# Database\n"
        data += f"DATABASE_HOST={self.dbHost}\n"
        data += f"DATABASE_PORT={self.dbPort}\n"
        data += f"DATABASE_USER={self.dbUser}\n"
        data += f"DATABASE_PASSWORD={self.dbPass}\n"
        data += f"DATABASE_NAME={self.dbName}\n"
        data += "#RabbitMQ\n"
        data += f"RABBITMQ_SERVER_HOST={self.rmqHost}\n"
        data += f'RABBITMQ_SERVER_PORT=""\n'
        data += "#Database Sync\n"
        data += f"DB_SYNC_SERVER={self.rmqHost}\n"
        data += f"DB_SYNC_PORT=\n"
        data += "#Client Configuration\n"
        data += "IS_SERVER=0\n"
        data += f"HOST_ID={self.clientId}\n"
        data += f"HOST_NAME={self.clientName}\n"
        data += f"HOST_QUEUE={self.rmqQueue}\n"
        data += f'HOST_TOPIC="{self.rmqTopic}"\n'
        file = open(".env", "w")
        file.write(data)
        file.close()
        print("[!] Data berhasil disimpan ke file konfigurasi")
        print("[!] Server Secret Key : %s" % self.secretKey)

    def inputServer(self):
        while True:
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

        self.serverName = input("[+] Nama Server\t\t: ")
        self.rmqHost = input("[+] RabbitMQ Host\t: ")
        self.secretKey = uuid.uuid4()
        self.writeServerConfigFile()
        self.createTableClients()
        self.createTableChangelog()
        self.createTableInbox()
        self.createTableOutbox()
        self.createTriggerChangeToOutbox()
        self.createTriggerTable()

    def inputClient(self):
        # database
        while True:
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
        if mode == 1:
            self.truncateTable("inbox")
            print("[/] Tabel inbox => dikosongkan")
            self.dropTrigger("changelog_to_outbox")
            print("[/] Trigger changelog_to_outbox => dihapus")
            self.dropTable("changelog")
            print("[/] Tabel changelog => dihapus")
            self.dropTable("outbox")
            print("[/] Tabel outbox => dihapus")
            self.dropTriggerAuditLog()
        elif mode == 2:
            self.truncateTable("inbox")
            print("[/] Tabel inbox => dikosongkan")
            self.truncateTable("outbox")
            print("[/] Tabel outbox => dikosongkan")
            self.truncateTable("changelog")
            print("[/] Tabel changelog => dikosongkan")
            self.dropTrigger("changelog_to_outbox")
            print("[/] Trigger changelog_to_outbox => dihapus")
            self.createTriggerChangeToOutbox()

        # registrasi client
        while True:
            self.clientName = input("[+] Nama Client\t\t: ")
            self.rmqHost = input("[+] Sync Server\t\t: ")
            self.secretKey = input("[+] Server Secret Key\t: ")
            url = "http://%s:%d%s" % (self.rmqHost, self.regisPort, self.regisRoute)
            form = {"name": self.clientName, "secretKey": self.secretKey}
            try:
                print("[/] Memproses registrasi ke server...")
                res = requests.post(url, form)
                res = json.loads(res.text)
                if res["status"]:
                    print("[!] Registrasi client ke server berhasil!")
                    self.clientId = res["id"]
                    self.rmqQueue = res["queue"]
                    self.rmqTopic = res["topic"]
                    break
                else:
                    print("[x] Registrasi gagal : %s" % res["message"])
            except:
                print("[x] Terjadi gangguan. Coba beberapa saat lagi")
        self.writeClientConfigFile()

    def run(self):
        print("=== INISIASI SERVICE SINKRONISASI DATABASE ===")
        tipe = int(input("Tipe Host [(1) Server / (2) Client] : "))
        if tipe == 1:
            self.inputServer()
        elif tipe == 2:
            self.inputClient()
        print("\n[!] Instaliasi service berhasil!")


init = Init()
init.run()
