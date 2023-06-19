#! /bin/python3
from subprocess import Popen, PIPE, STDOUT, DEVNULL
import time
import curses

# from os import getenv
from dotenv import load_dotenv
from prettytable import PrettyTable

load_dotenv()


class RunServices:
    def pbar(self, window):
        processor = Popen("src/processor.py", stdin=PIPE, stdout=DEVNULL, stderr=STDOUT)
        producer = Popen("src/producer.py", stdin=PIPE, stdout=DEVNULL, stderr=STDOUT)
        consumer = Popen("src/consumer.py", stdin=PIPE, stdout=DEVNULL, stderr=STDOUT)

        services = {
            "processor": processor,
            "producer": producer,
            "consumer": consumer,
        }
        # if getenv("IS_SERVER"):
        #     register = Popen(
        #         "src/register.py", stdin=PIPE, stdout=DEVNULL, stderr=STDOUT
        #     )
        #     services["register"] = register
        # chars = '⠋ ⠙ ⠚ ⠞ ⠖ ⠦ ⠴ ⠲ ⠳ ⠓'
        # loadingstr = '⠋ ⠙ ⠚ ⠒ ⠂ ⠂ ⠒ ⠲ ⠴ ⠦ ⠖ ⠒ ⠐ ⠐ ⠒ ⠓ ⠋'
        # loadingchars = loadingstr.split(' ')
        loadingchars = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]
        loading_index = 0
        stop_icon = ""
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
            time.sleep(0.1)
            if loading_index >= len(loadingchars) - 1:
                loading_index = 0
            else:
                loading_index += 1
            if stopCount == 3:
                break

    def run(self):
        try:
            curses.wrapper(self.pbar)
            if curses.has_colors():
                curses.start_color()
        except KeyboardInterrupt:
            print("\nExit..")


app = RunServices()
app.run()
