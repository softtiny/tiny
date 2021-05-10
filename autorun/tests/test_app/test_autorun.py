from autorun.tests import TestController
from autorun.utils.tools import git_clone

class TestAutoRun(TestController):
    def test_git(self):
        self.app.bash.run(git_clone("https://github.com/softtiny/tg2","tg2"))
