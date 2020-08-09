nohup uwsgi -s /tmp/yourapplication.sock --manage-script-name --virtualenv --mount /yourappliction=app:app &
