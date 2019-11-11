import smtplib
import csv
from os.path import basename
from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

class EmailOp:
    def __init__(self):
        config = self.parseConf()
        if config["proxy"]:
            import socks
            socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, '127.0.0.1', 1080)
            socks.wrapmodule(smtplib)
        try:
            smtp=smtplib.SMTP(host=config['host'],port=config['port'])
            smtp.starttls()
            smtp.login(config['user'],config['password'])
            message='hahaha'
            msg = MIMEMultipart()
            msg['From'] = config['user']
            msg['To'] = config['email2']
            msg['Subject'] = 'test'
            msg.attach(MIMEText(message, 'plain'))
            with open(config['dbpath'],'rb') as file:
                part = MIMEApplication(
                        file.read(),
                        Name= basename(config['dbpath'])
                        )
            part['Content-Disposition'] = 'attachment; filename="{}"'.format(basename(config['dbpath']))
            msg.attach(part)
            smtp.send_message(msg)
            del msg
            smtp.quit()
        except smtplib.SMTPResponseException:
            error_code = SMTPResponseException.smtp_code
            error_message = SMTPResponseException.smtp_error
            print("Error code:"+error_code)
            print("Message:"+error_message)
        except Exception as err:
            print("{} fail {}".format(type(err),err))
    def parseConf(self):
        with open('../config/sEmail.csv') as file:
            reader = csv.DictReader(file)  
            config = next( reader )
        return config
