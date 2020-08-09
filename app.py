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
    if os.path.exists(f'/home/mac/.cache/pgithub/{url}'):
        return send_file(f'/home/mac/.cache/pgithub/{url}') 
    else:
        command = [ 
            'curl',
            '-L',
            '--output',
            f'/home/mac/.cache/pgithub/{url}',
            f'{SITE_NAME}/{path}'
        ]
        print(command)
        subprocess.call(command)
        return send_file(f'/home/mac/.cache/pgithub/{url}') 
    return "index page"
