import schedule
from emailOp import EmailOp
import time
def jobdev():
    print('dev')
def job():
    EmailOp()

if True:
    jobdev()
    schedule.every(3).seconds.do(jobdev)
else:
    job()
    schedule.every(1).days.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)

