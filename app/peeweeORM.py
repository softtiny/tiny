from peewee import *
from playhouse.sqlcipher_ext import SqlCipherDatabase
import datetime
db = SqlCipherDatabase('vpngate.db',passphrase="qwe123qwe")

class BaseModel(Model):
    class Meta:
        database=db

class vpngateModel(Model):
    class Meta:
        database=db
    ip=CharField()
    port=CharField()
    proto=CharField()
    score=CharField()
    ping = CharField()
    speed=CharField()
    countrylong = CharField()
    countryshort = CharField()
    numvpnsessions = CharField()
    uptime = CharField()
    totalusers = CharField()
    totaltraffic = CharField()
    logtype=CharField()
    operator=CharField()
    message=CharField()
    config = TextField()
    createtime=DateTimeField(default=datetime.datetime.now)
    updatetime=DateTimeField(default=datetime.datetime.now)

if __name__=='__main__':
    db.connect()
    db.create_tables([BaseModel,vpngateModel,])
