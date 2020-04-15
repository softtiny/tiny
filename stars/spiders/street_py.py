# -*- coding: utf-8 -*-
import scrapy
import json

class StreetPySpider(scrapy.Spider):
    name = 'street.py'
    allowed_domains = ['npmjs.com']
    start_urls = ['https://www.npmjs.com/package/streetscape.gl?activeTab=dependents']

    def parse(self, response):
        scriptstr = response.xpath("//script[@integrity]/text()").extract()[0]
        objstr = scriptstr[21:]
        oData = json.loads(objstr)
        oContext = oData["context"]
        oDown = oContext["downloads"]
        print(oDown)
        pass
