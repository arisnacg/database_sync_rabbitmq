import sys
from datetime import datetime

if len(sys.argv) > 1:
    data_size = int(sys.argv[1])
else:
    print("No arguments provided.")
    exit(1)

sql = ""
nominal_ukt = 22
flag = 2

for i in range(1, data_size + 1):
    waktu = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    sql += f"DELETE FROM tb_trx WHERE nim = {i};"
    if i < data_size:
        sql += "\n"


file_path = f"./test/output/{data_size}_data_delete.sql"
with open(file_path, "w") as file:
    file.write(sql)
