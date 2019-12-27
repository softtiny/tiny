# -*- coding: utf-8 -*-
import scrapy
from scrapy_splash import SplashRequest



script = """
function main(splash,args)
    assert(splash:go(args.url))
    assert(splash:wait(1.0))
    assert( splash:evaljs("document.title='23423'") )
    --assert( splash:evaljs("document.write(JSON.stringify(window.__context__.context.downloads))") )
    return splash:evaljs("JSON.stringify(window.__context__.context.downloads)")
end

"""



class UberstreetSpider(scrapy.Spider):
    name = 'uberstreet'
    allowed_domains = ['127.0.0.1']
    start_urls = ['http://127.0.0.1:8088']
    custom_settings = {
            'DOWNLOADER_MIDDLEWARES':{
                'scrapy_splash.SplashCookiesMiddleware': 723,
                'scrapy_splash.SplashMiddleware': 725,
                'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810,               
            },
            'SPLASH_URL':'http://localhost:8050/',
            'SPIDER_MIDDLEWARES':{
               'scrapy_splash.SplashDeduplicateArgsMiddleware': 100,
                    
            },
            'DUPEFILTER_CLASS':'scrapy_splash.SplashAwareDupeFilter',
            'HTTPCACHE_STORAGE':'scrapy_splash.SplashAwareFSCacheStorage',
    }

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(url, self.parse,endpoint="execute",args={'lua_source':script,})

    def parse(self, response):
        with open('uberstreet_npmjs_org.json','wb') as file:
            file.write(response.body)
