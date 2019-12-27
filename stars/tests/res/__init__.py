import os
from scrapy.http import HtmlResponse,Request

def fake_response_from_file(file_name,url=None):
    if not url:
        url = "http://www.google.com"
    request = Request(url=url)
    rel_path = os.path.join(__file__,"../../static",file_name) 
    abs_path = os.path.abspath(rel_path)
    with open(abs_path,'r',encoding="utf-8") as file:
        file_content = file.read()
    response = HtmlResponse(
        request=request,
        url=url,
        body=file_content,
        encoding='utf-8'
    )
    return response

if __name__=='__main__':
    print(__file__)
    print(os.path.abspath(__file__))
