import httplib2
durl = 'http://104.160.37.173/download/ips.db'
class Loaddb:
    def __init__(self):
        h = httplib2.Http()
        resp,content = h.request(durl)
        with open("ips.db",'wb') as file:
            file.write(content)

        
