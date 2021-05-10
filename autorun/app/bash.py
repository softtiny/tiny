import subprocess
from .settings import settings
from os import path
import os

class BaseBash:
    def __init__(self):
        self.workDir = settings['workplace']
        logDir = settings['logdir']
        self.logDir = path.abspath(path.join(self.workDir,logDir))
        self.logname= settings['buildname']
        self.logfilepath = path.abspath( path.join(self.logDir,self.logname) )
        if not path.exists(self.logDir):
           os.makedirs(self.logDir) 
        with open(self.logfilepath,'a'):
            pass
    def run(self,cmds):
        tmpFile = open(self.logfilepath,"a")
        print(" ".join(cmds))
        subprocess.call(cmds,stdout=tmpFile,cwd=self.workDir,stderr=tmpFile)
        tmpFile.close()
