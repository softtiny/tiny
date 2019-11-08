from app.vpngateapp import VpngateApp
import schedule
import time
from app import config
def job():
    app = VpagateApp()
    app.reqUrl('http://www.vpngate.net/api/iphone/')

def jobdev():
    print('dev')
    with open('test.log','a') as file:
        file.write("asdfb\n")
if config.DEV:
    jobdev()
    schedule.every(3).seconds.do(jobdev)
else:
    job()
    schedule.every(2).days.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)
