from autorun.utils import tools
from nose.tools import eq_

def test_git_clone():
    tools.git_clone("https://github.com/TurboGears/tg2.git",'tg2')
