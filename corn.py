import schedule
from loaddb import Loaddb
import time
DEBUG = True

def jobdev():
    print("dev")
def job():
    Loaddb()

if DEBUG:
    jobdev()
    schedule.every(3).seconds.do(jobdev)
else:
    job()
    schedule.every(2).days.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)
