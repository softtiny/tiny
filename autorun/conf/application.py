from autorun.app import App

def make_app(global_conf,**local_conf):
    App.make_conf(*global_conf,**local_conf)
    return App()
