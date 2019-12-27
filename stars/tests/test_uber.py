import unittest
from stars.spiders.uberstreet import UberstreetSpider
from stars.tests.res import fake_response_from_file

class UberTestCase(unittest.TestCase):
    def setUp(self):
        self.spider = UberstreetSpider()
    def test_res(self):
        for step in self.spider.start_requests():
            print(dir(self.spider))
            print(step)
