import time
import env
from database import Database

#############################################################################
# INSERT HURUF N SAMPAI Z KE CLIENT
#############################################################################
db = Database(
    host="192.168.43.197",
    port=3306,
    user="server",
    password="server",
    databaseName="rabbitmq_client"
)
db.connect()

print("=====================================")
print("CLIENT: N -> Z")
print("=====================================")
for i in range(78, 91):
  query = "INSERT INTO tb_huruf(karakter) VALUES ('%s')" % (chr(i))
  print("INSERT HURUF : %s" % chr(i))
  db.insert(query)
