#! /bin/python3
from subprocess import Popen, PIPE, STDOUT, DEVNULL
import time
import curses
from colored import fg, bg, attr

from prettytable import PrettyTable

def pbar(window):
    service_one = Popen("./service_one.py", stdin=PIPE, stdout=PIPE, stderr=STDOUT)
    service_two = Popen("./service_two.py", stdin=PIPE, stdout=PIPE, stderr=STDOUT)
    service_three = Popen("./service_three.py", stdin=PIPE, stdout=PIPE, stderr=STDOUT)

    services = {
            "producer": service_one,
            "consumer": service_two,
            "sync": service_three,
            }
    # chars = '⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓'
    # loadingstr = '⠋ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋'
    # loadingchars = loadingstr.split(' ')
    loadingchars = ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏']
    loading_index = 0
    stop_icon = ''
    while True:
        x = PrettyTable()
        x.field_names = ["Service Name", "Status"]
        window.clear()
        stopCount = 0
        for key, service in services.items():
            if service.poll() == None:
                # text += f'Service: {key} is running... \n'
                x.add_row([key.upper(), f"{loadingchars[loading_index]}  Running"])
            else:
                stopCount += 1
                # text += f'Service: {key} stopped!\n'
                x.add_row([key.upper(), f"{stop_icon}  Stopped"])
        window.addstr(1, 0, "Audit Log + RabbitMQ services:")
        window.addstr(2, 0, x.get_string())
        window.refresh()
        time.sleep(.1)
        if loading_index >= len(loadingchars)-1:
            loading_index = 0
        else:
            loading_index += 1
        if(stopCount == 3):
            break

try:
    curses.wrapper(pbar)
    if curses.has_colors():
        curses.start_color()
except KeyboardInterrupt:
    print("Exit..")
