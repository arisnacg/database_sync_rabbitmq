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

for i in range(50, 100):
    query = "INSERT INTO tb_buku(nama_buku) VALUES ('%s')" % ("Buku-"+str(i+1))
    print(query)
    db.insert(query)