#!/bin/bash

echo "APACHE installation Started!!"


if [ -d /opt/tarball ]
then
        echo "/opt/tarball Folder already exist"
else
        mkdir /opt/tarball
fi

sleep 2

cd /opt/tarball

if [ -f httpd-2.4.16.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/httpd-2.4.16.tar.gz
fi

if [ -f pcre-8.35.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/pcre-8.35.tar.gz
fi

if [ -f openssl-1.0.2d.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/openssl-1.0.2d.tar.gz
fi

if [ -f apr-1.5.1.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/apr-1.5.1.tar.gz
fi

if [ -f apr-util-1.5.4.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/apr-util-1.5.4.tar.gz
fi

if [ -f tomcat-connectors-1.2.40-src.tar.gz ]
then
	echo "Package already downloaded"
else
	wget --ftp-user=181builds --ftp-password=181builds ftp://bizdp4.prognocis.com/PrognocisInstall/PrognocisSetup/tomcat-connectors-1.2.40-src.tar.gz
fi

sleep 2

cd /opt/tarball

echo "Checking Openssl Version openssl-1.0.2d"
if [ -d /usr/local/ssl1.0.2d ]
then
        echo "openssl-1.0.2d already installed"
else
        echo "Openssl was install. Now Installing Openssl version openssl-1.0.2d"
        tar -zxvf openssl-1.0.2d.tar.gz && cd openssl-1.0.2d && ./Configure && ./config -fPIC --prefix=/usr/local/ssl1.0.2d && make &&  make install
fi

cd /opt/tarball

echo "Checking APR installed OR not"
if [ -d /usr/local/apr ]
then
    echo "APR has been already installed."
else
        echo "Installing APR version apr-1.5.1"
        cd /opt/tarball && tar -zxvf apr-1.5.1.tar.gz && cd apr-1.5.1 && ./configure && make && make install
fi

sleep 2

cd /opt/tarball

if [ -f /usr/local/apr/bin/apr-1-config ]
then
        echo "APR-UTILS has been already install"
else
        echo "Installing APR Util version apr-1.5.4"
        cd /opt/tarball && tar -zxvf apr-util-1.5.4.tar.gz && cd apr-util-1.5.4 && ./configure --with-apr=/usr/local/apr && make && make install
fi

sleep 2

cd /opt/tarball

echo "Checking PCRE"
if [ -d /usr/local/pcre ]
then
    echo "PCRE has been already installed."
else
    echo "PCRE was not install, Installing PCRE now."
    tar -zxvf pcre-8.35.tar.gz && cd pcre-8.35 && ./configure --prefix=/usr/local/pcre && make && make install
fi

sleep 2
cd /opt/tarball

echo "installing apache2.4.16"
tar -zxvf httpd-2.4.16.tar.gz
cd httpd-2.4.16
./configure --prefix=/usr/local/apache2416 --with-ssl=/usr/local/ssl1.0.2d --enable-mods-shared=all --enable-deflate --enable-ssl --enable-so --with-pcre=/usr/local/pcre --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr && 
make && make install
echo "apache24 installation completed"
cd ..

sleep 2
cd /opt/tarball

echo "compile tomcat connector version tomcat-connectors-1.2.40"
tar -zxvf tomcat-connectors-1.2.40-src.tar.gz
cd tomcat-connectors-1.2.40-src/native && ./configure --with-apxs=/usr/local/apache2416/bin/apxs && make && make install
echo "connector compilation completed"

ln -s /usr/local/apache2416 /bizmatics/

chmod -R 775 /usr/local/apache2416
chown -R prognocis.prognocis /usr/local/apache2416

mv /usr/local/apache2416/conf /usr/local/apache2416/conf-org
cp -rvp /usr/local/apache24/conf /usr/local/apache2416/conf



echo "Installation completed"
echo "New apache version is `/usr/local/apache2416/bin/apachectl -v`"
