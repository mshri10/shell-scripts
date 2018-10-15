#!/bin/bash
DATE=`date \+\%a`
DAY=`date \+\%D`
HOST=`hostname`
src=/usr/local/Prognocis
dest3=/databackup/data2/west
rsync -Lrltzuv --delete --exclude-from=/bizmatics/donotcopy.txt $src/ $dest3/Sun/bizserv14 > /root/backup/backup$DATE.out 2>/root/backup/backup$DATE.err
if [ "$?" -eq "0" ]; then
echo `echo "Bakup Information : Data backup has completed on $DATE on $HOST" | mail -s "Bakup Information : Data backup has completed on $DATE on $HOST" tghadi@bizmaticsinc.com shrikant.m@bizmaticsinc.com -- -f bizserv14@mail.prognocis.com`
else
echo `cat /root/backup/backup$DATE.err | mail -s "Alert: Data backup has not completed on $DAY on $HOST"  tghadi@bizmaticsinc.com shrikant.m@bizmaticsinc.com -- -f bizserv14@mail.prognocis.com`
fi
