from autorun.app.settings import settings
class GitRun:
    def __init__(self,url,folder,**kdic):
        self.url=url
        self.folder=folder
    def render(self):
        return [settings['gitpath'],'clone',self.url,self.folder,]
