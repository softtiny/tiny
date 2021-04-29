from autorun.utils.git import GitRun

def git_clone(url,folder):
    gitrun = GitRun(url=url,folder=folder)
