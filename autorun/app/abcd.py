from .settings import settings
from os import path
import sys
import os
class StartRuning:
    def __init__(self):
        self.checking_workplace()
    def checking_workplace(self):
        workplace = settings['workplace']
        if path.exists(workplace):
            pass
        else:
            os.mkdir(workplace)
        pass
