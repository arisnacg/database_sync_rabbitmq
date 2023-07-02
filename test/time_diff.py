import sys
from datetime import datetime


def time_difference_seconds(datetime1, datetime2):
    timedelta = datetime2 - datetime1
    return timedelta.total_seconds()


d1 = input("date 1 :")
d2 = input("date 2 :")
datetime1 = datetime.strptime(d1, "%Y-%m-%d %H:%M:%S")
datetime2 = datetime.strptime(d2, "%Y-%m-%d %H:%M:%S")

difference_seconds = time_difference_seconds(datetime1, datetime2)
print(f"{difference_seconds} seconds")
