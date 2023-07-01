import sys
from datetime import datetime

if len(sys.argv) > 1:
    data_size = int(sys.argv[1])
else:
    print("No arguments provided.")
    exit(1)

sql = f"INSERT tb_trx(nim, waktu, nominal_ukt, flag) VALUES \n"

nominal_ukt = 11
flag = 1

for i in range(1, data_size + 1):
    waktu = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    sql += f"('{i}', '{waktu}', '{nominal_ukt}', '{flag}')"
    if i == data_size:
        sql += ";"
    else:
        sql += ",\n"

file_path = f"./test/output/{data_size}_data_insert.sql"

with open(file_path, "w") as file:
    file.write(sql)
