#!/bin/bash
# Randy Larson February 5, 2014 Useradd Script
clear
echo "This will add users to our servers"
sleep 2
# Change the default home directory
mkdir -p /home/remote
# Create private groups first
#
groupadd mary.jones -g 2000
groupadd mike.smith -g 2001 
groupadd harry.johnson -g 2002
groupadd rick.mays -g 2003
groupadd linda.keys -g 2004
# Now create users
#
useradd mary.jones -c "Mary Jones-Manager" -d /home/remote/mary.jones -u 2000 -g 2000 -s /bin/bash
useradd mike.smith -c "Mike Smith" -d /home/remote/mike.smith -u 2001 -g 2001 -s /bin/bash
useradd harry.johnson -c "Harry Johnson" -d /home/remote/harry.johnson -u 2002 -g 2002 -s /bin/bash
useradd rick.mays -c "Rick Mays" -d /home/remote/rick.mays -u 2003 -g 2003 -s /sbin/nologin
useradd linda.keys -c "Linda Keys-CEO" -d /home/remote/linda.keys -u 2004 -g 2004 -s /bin/bash
# Now create secondary groups
groupadd sales
groupadd sales-admin
usermod -a -G sales harry.johnson
usermod -a -G sales linda.keys
usermod -a -G sales mary.jones
usermod -a -G sales mike.smith
usermod -a -G sales rick.mays
usermod -a -G sales-admin linda.keys
usermod -a -G sales-admin mary.jones
mkdir -p /sales/sales-admin
# EOF
