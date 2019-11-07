from app.peeweeORM import vpngateModel
import unittest
ip = '10.2220.8.242'
class vpngateModelTestCase(unittest.TestCase):
    def step_create(self):
        vpngateModel.delete().where(vpngateModel.ip=="10.220.8.242").execute()
        vpngate = vpngateModel(ip=ip,port="343",score="12",ping="2",speed="34",countrylong="ssss",proto="sdf",countryshort="sdfs",numvpnsessions="34",uptime="32",totalusers="sdds",logtype="3",operator="pud",message="error",config="sssssss",totaltraffic="sdf")
        vpngate.save()
    def step_time(self):
        query = vpngateModel.select()
        print(len(query))
        for vp in query:
            vp.score="343"
            vp.save()
        vpngateModel.delete().where(vpngateModel.ip==ip).execute()
    def _step(self):
        yield self.step_create
        yield self.step_time
    def test_step(self):
        for step in self._step():
            try:
                step()
            except Exception as err:
                self.fail("{} fail {} err {}".format(step.__name__,type(err),err))
