lynx  --source 127.0.0.1/server-status | /opt/simon/status_apache2.pl | sed -e 's/<\/td>//'
