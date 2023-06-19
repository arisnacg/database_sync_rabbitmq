#! /bin/python3
import time


def write_file(file_path):
    with open(file_path, "w") as file:
        file.write("")


def append_to_file(file_path, text):
    with open(file_path, "a") as file:
        file.write(text)


file_path = "./log_one.txt"  # Replace with the actual file path
write_file(file_path)


print("Service one is running...")
for i in range(10):
    logstr = "Log %d...\n" % (i + 1)
    append_to_file(file_path, logstr)
    time.sleep(1)