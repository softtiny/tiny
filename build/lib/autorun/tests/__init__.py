from paste.deploy import loadapp,appconfig
from os import getcwd

application_name= 'main'

def load_app(name=application_name):
    return loadapp('config:test.ini#%s' % name,relative_to=getcwd())



class TestController:
    application_under_test = application_name
    def setUp(self):
        self.app=load_app()
    def test_ok(self):
        "okkking"
        pass
    def tearDown(self):
        pass
