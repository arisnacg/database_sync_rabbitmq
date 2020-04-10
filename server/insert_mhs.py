import time
import env
from database import Database

db = Database(
    host=env.DATABASE_HOST,
    port=env.DATABASE_PORT,
    user=env.DATABASE_USER,
    password=env.DATABASE_PASSWORD,
    databaseName=env.DATABASE_NAME
)
db.connect()

i = 1
while(True):
    query = "INSERT INTO tb_mahasiswa(nim, nama) VALUES ('%s', '%s')" % ("160444"+str(i), "Mahasiswi #"+str(i))
    db.insert(query)
    print(query)
    i += 1
    time.sleep(1)