from autorun.utils import tools
from nose.tools import eq_

def test_git_clone():
    cmds=tools.git_clone("https://github.com/TurboGears/tg2.git",'tg2')
    eq_(cmds[1],'clone')
