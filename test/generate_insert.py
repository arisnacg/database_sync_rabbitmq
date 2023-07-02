import sys
from datetime import datetime

if len(sys.argv) > 1:
    data_size = int(sys.argv[1])
else:
    print("No arguments provided.")
    exit(1)

start_index = 1
if len(sys.argv) > 2:
    start_index = int(sys.argv[2])
sql = ""

nominal_ukt = 11
flag = 1

for i in range(start_index, data_size + 1):
    waktu = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    sql += f"INSERT tb_trx(nim, waktu, nominal_ukt, flag) VALUES ('{i}', '{waktu}', '{nominal_ukt}', '{flag}');\n"

file_path = f"./test/output/{data_size}_data_insert.sql"

with open(file_path, "w") as file:
    file.write(sql)
