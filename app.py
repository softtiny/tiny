from flask import Flask,request,send_file
import os
import subprocess

app = Flask(__name__)

if not os.path.exists('/home/mac/.cache/pgithub'):
    os.mkdir("/home/mac/.cache/pgithub")
SITE_NAME='https://github.com'

@app.route('/<path:path>')
def page_node_found(path):
    print(dir(request))
    url = request.url
    for spec in [':','/','.','?','#']:
        url = "".join( url.split(spec)  )
    if os.path.exists('/home/mac/.cache/pgithub/{}'.format(url)):
        return send_file('/home/mac/.cache/pgithub/{}'.format(url)) 
    else:
        command = [ 
            'curl',
            '-L',
            '--output',
            '/home/mac/.cache/pgithub/{}'.format(url),
            '{}/{}'.format(SITE_NAME,path),
        ]
        print(command)
        subprocess.call(command)
        return send_file('/home/mac/.cache/pgithub/{}'.format(url)) 
    return "index page"
