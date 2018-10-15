#/etc/init.d/apache2416 stop
kill -9 `ps -ef |grep -i httpd | grep -v grep | awk {'print $2'}`
sleep 10
for i in `ipcs -s | awk '/progoweb/{print $2}'`; do (ipcrm -s $i); done
dt=`date \+\%F`


mv /usr/local/apache2416/logs/mod_jk.log /usr/local/apache2416/logs/mod_jk_$dt.log
gzip -f /usr/local/apache2416/logs/mod_jk_$dt.log

sleep 5

mv /usr/local/apache2416/logs/error_log /usr/local/apache2416/logs/error_log_$dt.log
gzip -f /usr/local/apache2416/logs/error_log_$dt.log

sleep 5

mv /usr/local/apache2416/logs/access_log /usr/local/apache2416/logs/access_log_$dt
gzip -f /usr/local/apache2416/logs/access_log_$dt

sleep 5

/etc/init.d/apache2416 start
chown -R prognocis.prognocis /usr/local/apache2416/logs/*
