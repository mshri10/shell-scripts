#!/bin/bash


########### add users ##############3
echo `adduser -u 500 prognocis`
echo `echo prognocis:pr0gn0c1s | chpasswd`

############## user addition for sudo access ###############33
echo "prognocis       ALL=(ALL)       ALL" >> /etc/sudoers
echo "59 * * * * root ntpdate 192.168.1.15" >> /etc/crontab
echo "fs.file-max=20000000" >> /etc/sysctl.conf
echo "*       soft    nofile  12288" >> /etc/security/limits.conf
iecho "*       hard    nofile  12288" >> /etc/security/limits.conf


###############################################
#Pre-requisites installation for Apache-Tomcat#
###############################################
groupadd -g 25 progoweb && useradd -c "Apache Server" -d /srv/www -g progoweb -s /sbin/nologin -u 25 progoweb

yum -y install gcc gcc-cpp gcc-c++
yum install pcre-devel zlib-devel -y


#######################################
#Creating folder where files will dump#
#######################################
mkdir /opt/tarball/

############################
#Download required tarballs#
############################

echo "Downloading Apache"
wget https://archive.apache.org/dist/httpd/httpd-2.4.10.tar.gz

echo "Downloading Apache APR tarball"
wget http://www.motorlogy.com/apache//apr/apr-1.5.1.tar.gz

echo "Downloading Apache APR-Utils tarball"
wget http://www.motorlogy.com/apache//apr/apr-util-1.5.4.tar.gz

echo "Downloading Openssl tarball"
wget https://www.openssl.org/source/openssl-1.0.1l.tar.gz

echo "Downloading Tomcat connector for apache-tomcat"
wget http://tomcat.apache.org/download-connectors.cgi/tomcat-connectors-1.2.40-src.tar.gz

######################
# Installation APACHE#
######################

echo "Starting installation for Apache APR"
tar -zxvf apr-1.5.1.tar.gz
cd apr-1.5.1
./configure
make && make install
echo "Apache APR installation Done"

cd ..

echo "Starting installation for Apache APR-UTILS"
tar -zxvf apr-util-1.5.4.tar.gz
cd apr-util-1.5.4
./configure --with-apr=/usr/local/apr
make && make install

echo "Apache APR-UTILS installation Done"

cd ..

echo "Starting installation for openssl"
tar -zxvf openssl-1.0.1l.tar.gz
./Configure
##(Note : -fPIC is for 64 bit OS)
./config -fPIC 
make &&  make install
echo "Apache Openssl Installation Done"

cd ..

echo "installing apache24"
tar -zxvf httpd-2.4.10.tar.gz
cd httpd-2.4.10
./configure --prefix=/usr/local/apache24 --with-ssl=/usr/local/ssl --enable-mods-shared=all --enable-deflate --enable-ssl --enable-so  --enable-mpms-shared=all
make && make install
echo "apache24 installation completed"
cd ..

echo "Compile Tomcat connector"
tar -zxvf tomcat-connectors-1.2.37-src.tar.gz
cd native/
./configure --with-apxs=/usr/local/apache24/bin/apxs
make && make install
echo "Tomcat connector installation done"
cd ..

############Configuration of Apache##############

echo "Change directory to apache"
mkdir /tmp/apache-files
cd /tmp/apache-files

