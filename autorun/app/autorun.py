
class _Autorun:
    def __init__(self):
        pass
    def make_conf(self,*global_conf,**local_conf):
        print(global_conf)
        print(local_conf)

    def __call__(self):
        pass
