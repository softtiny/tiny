from autorun.conf.settings import base_conf
class _settings(dict):
    def __init__(self,*args,**kwargs):
        super(_settings,self).__init__(*args,**kwargs)
        self.update(base_conf)
    def update_filter(self,global_conf,**kwargs):
        filter_keys = set(self.keys())
        for arg in global_conf.keys():
            if arg in filter_keys:
                self.update({arg:global_conf[arg],})
        for arg in kwargs.keys():
            if arg in filter_keys:
                self.update({arg:kwargs[arg],})
settings = _settings()

