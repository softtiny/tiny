from .settings import settings
from . import abcd
class _Autorun:
    def __init__(self):
        pass
    def make_conf(self,*global_conf,**local_conf):
        settings.update_filter(*global_conf,**local_conf)

    def __call__(self):
        abcd.StartRuning()
        pass
