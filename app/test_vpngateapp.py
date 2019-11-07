import unittest
from os import path
from app.vpngateapp import VpngateApp
from app.peeweeORM import vpngateModel
import datetime
class VpngateAppTestCase(unittest.TestCase):
    def step_parsefile(self):
        self.app=VpngateApp()
        url = path.abspath(path.join(__file__,'../../assets/one.csv'))
        self.app.parseFile(url)
        query = vpngateModel.select()
        print(len(query))
        query = query[0]
        print(query.createtime)
        print(query.updatetime)
        print(query.id)
        print(query.logtype)
        print(query.operator)
        print(query.proto)
    def step_reqUrl(self):
        self.app=VpngateApp()
        self.app.reqUrl('http://321tips.j19o.cn:8899/one.csv')
    def step_reqUrlOnline(self):
        self.app=VpngateApp()
        self.app.reqUrl('http://321tips.j19o.cn:8899/one.csv')
        query = vpngateModel.select()
        self.assertLess(1,len(query))
        print(len(query))
    def step_online(self):
        self.app=VpngateApp()
        self.app.reqUrl('http://www.vpngate.net/api/iphone/')
        query = vpngateModel.select()
        self.assertLess(1,len(query))
        print(len(query))

    def step_useProxy(self):
        self.app=VpngateApp()
        self.app.useProxy('127.0.0.1',1080)
        self.app.reqUrl('http://www.vpngate.net/api/iphone/')
        query = vpngateModel.select()
        self.assertLess(1,len(query))
        print(len(query))
    def step_deleteOutTime(self):
        app = VpngateApp()
        query = vpngateModel.select()
        time1 = datetime.datetime.now()
        print(time1)
        for item in query[1:50]:
            item.update(updatetime=time1).execute()
        query = vpngateModel.select().order_by(vpngateModel.updatetime.desc())
        print(query[0].updatetime)
        app.deleteOutTime()
        query = vpngateModel.select().order_by(vpngateModel.updatetime)
        print(query[0].updatetime)
        #self.assertEqual(time1,query[1].updatetime)
        #self.assertEqual(time1,query[-1].updatetime)
    def _step(self):
        #yield self.step_parsefile
        #yield self.step_reqUrl
        #yield self.step_reqUrlOnline
        #yield self.step_useProxy
        yield  self.step_online
        #yield self.step_deleteOutTime
    def test_step(self):
        for step in self._step():
            try:
                step()
            except Exception as err:
                self.fail("{} fail {} err {}".format(step.__name__,type(err),err))

