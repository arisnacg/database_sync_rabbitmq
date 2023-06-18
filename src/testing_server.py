import time
import env
from database import Database

#############################################################################
# INSERT HURUF A SAMPAI M KE SERVER
#############################################################################
db = Database(
    host="127.0.0.1",
    port=3306,
    user="root",
    password="",
    databaseName="rabbitmq_server"
)
db.connect()


print("=====================================")
print("SERVER: A -> M")
print("=====================================")
for i in range(65, 78):
    query = "INSERT INTO tb_huruf(karakter) VALUES ('%s')" % (chr(i))
    print("INSERT HURUF : %s" % chr(i))
    db.insert(query)
