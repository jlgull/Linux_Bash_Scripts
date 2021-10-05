#!/bin/bash
# Randy Larson April 22, 2013
# Note: RDIR is the "Remote Directory Where Local Files will Be Stored"
# Note: TDIR is the "Target Directory Being Backed Up"
# Note: MP is the "Local Mount Point Where RDIR Will be Mounted"
# Note: The "Date Variables will be Included in the TAR File-names"
######### WARNING ##########################################################
# Often times root will create a script for backups; add it to a crontab job
# and then forget about it. One of the critical single points of failure is:
# The remote server where the backups will be stored is down!
# The NFS server service is not functioning!
# The network is down or networking service is not available on one or both  servers!
# To caution against this I have added a file called verify.txt on the
# remote server
# If the NFS fails to mount, then the Conditional Statement will e-mail root and exit.
# I have a pre-made e-mail that contains the problem called
# /root/warning.txt. Had this been a production server, I would have sent
# a text message instead. Example: 6025551212@vtext.com
# b=local abbreviated month
# d=day of the month
# Y= year
# H= hour
# M= minutes
# S= Seconds
#
a=`date +%b-%d-%Y`
b=`date +%H`
c=`date +%M`
d=`date +%S`
# Note X= your IP Address of your backup server 
# EXAMPLE
# RDIR=192.168.0.X:/var/ftp/pub/hr-backup
RDIR=192.168.0.X:/var/ftp/pub/hr-backup
TDIR=/hr
MP=/root/backups
mount $RDIR $MP

        if [ -a /root/backups/verify.txt ]; then
tar -cvzf $MP/hr-backup-$a-$b-$c-$d.tar.gz $TDIR
umount $RDIR

        else
# Note: The echo statement is only needed for testing!
echo "Remote Directory Not Mounted!"
mail -s "Critical Warning" root@localhost < /root/bin/messages/warning.txt
exit
	fi

# EOF
