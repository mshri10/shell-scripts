HOST=`/bin/hostname`
        IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
md5sum -c  /home/webmaster/config.md5  > /home/webmaster/report1
cat /home/webmaster/report1 | grep FAILED | awk -F ":" '{print $1}' > /home/webmaster/report2
if [ -s  "/home/webmaster/report2" ]; then
for i in `cat /home/webmaster/report2`
do
        DT=`date +%d:%m:%Y:%R`
        aws s3 cp $i s3://nv-config-file-backup/$HOST-$IP/
        echo "$i $DT" >> /home/webmaster/config_mod_logs

done
> /home/webmaster/config.md5
for i in `cat /home/webmaster/filelist`; do md5sum $i >> /home/webmaster/config.md5 ; done
(echo -e "From: config_versioning@justbuylive.com  \nTo: infra@justbuylive.com \nMIME-Version: 1.0 \nSubject: Files of `/bin/hostname` uploaded in s3 bucket of date `date` \nContent-Type: text/html \n"; cat /home/webmaster/report2  ) | /usr/sbin/sendmail -t

rm -rf /home/webmaster/report1
rm -rf /home/webmaster/report2
fi
