# -*- coding: utf-8 -*-
import scrapy
from stars.items import StarsItem

base_domain = 'https://github.com'

class StarSpider(scrapy.Spider):
    name = 'star'
    allowed_domains = ['github.com']
    start_urls = ['https://github.com/search?l=JavaScript&o=desc&p=1&q=street&s=updated&type=Repositories']

    def parse(self, response):
        ullis = response.xpath("/html//main[@id='js-pjax-container']//ul[@class='repo-list']/li") 
        for liele in ullis:
            arr1 = liele.xpath(".//a[@class='muted-link']/text()").extract()
            if arr1:
                str2 = ''.join(arr1)
                str3 = str2.strip()
                if str3:
                    starnum = int(str3)
                    if starnum>200:
                        href = liele.xpath(".//a[@class='v-align-middle']/@href").extract()[0]
                        href = base_domain+href
                        timer= liele.xpath(".//relative-time/@datetime").extract()[0]
                        title= liele.xpath(".//a[@class='v-align-middle']/text()").extract()[0]
                        item = StarsItem()
                        item["href"] = href
                        item["timer"] = timer
                        item["title"] = title
                        yield item
        nexthref= response.xpath("////a[@class='next_page']/@href").extract()
        if nexthref:
            nexthref= nexthref[0]
            nexthref = base_domain+nexthref
            yield scrapy.Request(url=nexthref,callback=self.parse)
