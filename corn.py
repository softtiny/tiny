from app.vpngateapp import VpngateApp
import schedule
import time
from app import config
def job():
    app = VpagateApp()
    app.reqUrl('http://www.vpngate.net/api/iphone/')

def jobdev():
    print('dev')

if config.DEV:
    schedule.every(3).seconds.do(jobdev)
else:
    schedule.every(2).days.do(job)

while True:
    schedule.run_pending()
    time.sleep(1)
