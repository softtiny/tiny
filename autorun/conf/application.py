from autorun import Autorun

def make_app(global_conf,**local_conf):
    print(Autorun)
    App = Autorun()
    App.make_conf(global_conf,**local_conf)
    App()
    return App
