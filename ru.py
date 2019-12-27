from http.server import HTTPServer,BaseHTTPRequestHandler
import urllib
from urllib.request import urlopen
HOST_ADDRESS = ""
HOST_PORT = 8088
import os
import time
class RequestHandler(BaseHTTPRequestHandler):
    def send_response(self,code,message=None):
        self.log_request(code)
        self.send_response_only(code)
        self.send_header('Date',self.date_time_string())
        self.end_headers()
    def do_GET(self):
        if os.path.exists('./oo.html'):
            if int(time.time()) - int(os.path.getmtime('./oo.html')) < 36000000:
                print("< 36000000")
                with open('./oo.html',encoding="utf-8") as file:
                    text= file.read().encode('utf-8')
            else:  
                text = urlopen('https://npmjs.org/package/streetscape.gl').read()
                with open('./oo.html','wb') as file:
                    file.write(text)
        else:
            text = urlopen('https://npmjs.org/package/streetscape.gl').read()
            with open('./oo.html','wb') as file:
                file.write(text)
        self.send_response(200)
        self.wfile.write(text)

def run(server_class=HTTPServer,handler_class=BaseHTTPRequestHandler):
    server_address = (HOST_ADDRESS,HOST_PORT)
    httpd = server_class(server_address,handler_class)
    httpd.serve_forever()
if __name__=='__main__':
    run(handler_class=RequestHandler)
    
