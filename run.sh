rm nohup.out
rm /tmp/yourapplication.sock
nohup uwsgi -s /tmp/yourapplication.sock --manage-script-name --virtualenv ./venv --mount /yourappliction=app:app --uid www-data --gid www-data &
