diskcheck() {
if [ $SPACE -gt 55 ]
then
        exit
fi
}

svnrepobackup() {
for i in $FOLDER
do
        svnadmin hotcopy /var/svn/repo/$i  /home/chetanm/svnbackup/$i
done
cd /home/chetanm/
tar -zcvf $TAR_NAME.tar.bz2 svnbackup
aws s3 mv $TAR_NAME.tar.bz2 s3://jbl-git-svn-backup/jbl-svn/
rm -rf /home/chetanm/svnbackup/*
}
mkdir -p /home/chetanm/svnbackup
SPACE=`df -h | grep /dev/xvda1 | awk '{print $5}' | sed 's/%//'`
cd /var/svn/repo
FOLDER=`ls -d */`
TAR_NAME=`date +%Y%m%d`repo

diskcheck
svnrepobackup
