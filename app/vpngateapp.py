import csv
import base64
from app.peeweeORM import vpngateModel
import httplib2
import io
import datetime
from app import config

class VpngateApp:
    def __init__(self):
        self.proxy_ip=None
        dir_config = dir(config)
        if ('USEPROXY' in dir_config) and ('PROXY_IP' in dir_config):
            if config.USEPROXY and config.PROXY_IP:
                self.useProxy(config.PROXY_IP,config.PROXY_PORT)
        pass
    def deleteOutTime(self):
        lastupdate = vpngateModel.select().order_by(vpngateModel.updatetime.desc()).limit(1)
        lasttime = lastupdate[0].updatetime
        vpngateModel.delete().where(vpngateModel.updatetime!=lasttime).execute()
    def useProxy(self,ip,port):
        self.proxy_ip=ip
        self.proxy_port= port
    def parseFile(self,url):
        rows=[]
        with open(url) as file:
            for row in file:
                if not row.startswith('*'):
                    rows.append(row)
        reader = csv.DictReader(rows)
        self.saveToData(reader)
        self.deleteOutTime()
    def reqUrl(self,url):
        if self.proxy_ip:
            h = httplib2.Http(proxy_info=httplib2.ProxyInfo(
                httplib2.socks.PROXY_TYPE_SOCKS5,
                self.proxy_ip,
                self.proxy_port
                ))
        else:
            h = httplib2.Http()
        resp,content = h.request(url)
        rows=[]
        for row in content.decode('utf8').split('\n'):
            if not row.startswith('*'):
                rows.append(row)
        reader = csv.DictReader(rows)
        self.saveToData(reader)
        self.deleteOutTime()
    def saveToData(self,reader):
        print(len(reader))
        updatetime=datetime.datetime.now()
        for row in reader:
            ip=None
            port=None
            countrylong=row["CountryLong"]
            countryshort=row["CountryShort"]
            conf = row["OpenVPN_ConfigData_Base64"]
            config = base64.b64decode(conf).decode("UTF-8")
            score=row["Score"]
            ping = row["Ping"]
            speed = row['Speed']
            numvpnsessions=row['NumVpnSessions']
            uptime=row['Uptime']
            totalusers=row['TotalUsers']
            logtype=row['LogType']
            operator=row['Operator']
            message=row['Message']
            totaltraffic=row['TotalTraffic']
            for line in config.splitlines():
                if line.startswith("remote"):
                    _,ip,port = line.split(" ")
                elif line.startswith("proto"):
                    _,proto = line.split(" ")
            query=vpngateModel.select().where(vpngateModel.ip==ip)
            if len(query):
                query = query[0]
                query.update(
                    ip=ip,
                    port=port,
                    proto=proto,
                    score=score,
                    updatetime=updatetime,
                    ping=ping,
                    speed=speed,
                    countrylong=countrylong,
                    countryshort=countryshort,
                    numvpnsessions=numvpnsessions,
                    uptime=uptime,
                    totalusers=totalusers,
                    logtype=logtype,
                    operator=operator,
                    message=message,
                    config=config,
                    totaltraffic=totaltraffic
                    )
            else:
                query = vpngateModel(
                    ip=ip,
                    port=port,
                    proto=proto,
                    score=score,
                    updatetime=updatetime,
                    ping=ping,
                    speed=speed,
                    countrylong=countrylong,
                    countryshort=countryshort,
                    numvpnsessions=numvpnsessions,
                    uptime=uptime,
                    totalusers=totalusers,
                    logtype=logtype,
                    operator=operator,
                    message=message,
                    config=config,
                    totaltraffic=totaltraffic
                    )
            query.save()
 
