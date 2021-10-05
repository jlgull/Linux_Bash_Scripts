#!/bin/bash
# Randy Larson December 7, 2011
# THIS SCRIPT SHOULD BE RUN FROM SERVER-B THE BACKUP SERVER
# YOU MUST MODIFY YOUR PARTNER"S IP ADDRESS BELOW!
yum list
sleep 3
yum install vsftpd -y
mkdir /var/ftp/pub/hr-backup/
touch /var/ftp/pub/hr-backup/verify.txt
chattr +i /var/ftp/pub/hr-backup/verify.txt
service vsftpd start
chkconfig --level 35 vsftpd on
#### WARNING YOU MUST CHANGE THE IP ADDRESS TO MATCH YOUR LAB PARTNER'S IP!
echo "/var/ftp/pub/hr-backup/ 192.168.0.13/255.255.255.0(rw,no_root_squash,async)" >> /etc/exports
service nfs start
chkconfig --level 35 nfs on
chkconfig --list | grep nfs
sleep 3
service nfs status
sleep 2
showmount -e localhost
sleep 2
#EOF
