#!/bin/bash
file=`cat /bizmatics/vishu/service.txt`

for service in $file
do
/etc/init.d/$service stop
sleep 2
chkconfig $service off
echo "$service has been disabled"
sleep 2
done
