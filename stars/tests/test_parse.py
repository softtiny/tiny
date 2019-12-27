import unittest
from stars.tests.res import fake_response_from_file
from stars.spiders import star
class ParseTestCase(unittest.TestCase):
    def setUp(self):
        self.spider= star.StarSpider()

    def test_parse(self):
        response = fake_response_from_file('star0.html')
        self.spider.parse(response)
