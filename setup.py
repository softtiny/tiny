from setuptools import setup,find_packages

setup(
    name="autorun",
    version="0.0.1",
    author="tiny",
    author_email="tiny@xxxx.email",
    url="http://xxx.xxx.xxx",
    setup_requires=['pbr', 'setuptools'],
    pbr=True,
    test_suite='autorun.tests',
    packages=find_packages('autorun')
)
