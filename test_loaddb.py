import unittest
from loaddb import Loaddb
from os import path

class LoaddbTestCase(unittest.TestCase):
    def test_ok(self):
        Loaddb()
        self.assertTrue(path.exists('./ips.db'))

