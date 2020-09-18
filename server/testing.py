import time
import env
from database import Database

db = Database(
    host=env.DATABASE_HOST,
    port=env.DATABASE_PORT,
    user=env.DATABASE_USER,
    password=env.DATABASE_PASSWORD,
    databaseName="rabbitmq_server"
)
db.connect()

for i in range(65, 75):
    query = "INSERT INTO tes(huruf) VALUES ('%s')" % chr(i)
    print(query)
    db.insert(query)

db = Database(
    host=env.DATABASE_HOST,
    port=env.DATABASE_PORT,
    user=env.DATABASE_USER,
    password=env.DATABASE_PASSWORD,
    databaseName="rabbitmq_client1"
)
db.connect()

for i in range(75,85):
    query = "INSERT INTO tes(huruf) VALUES ('%s')" % chr(i)
    print(query)
    db.insert(query)

db.connect()