#!/bin/bash
#Add Machine Accounts to Domain
#Modifies /etc/password /etc/shadow /etc/group and /etc/samba/smbpasswd
#Usage addmachine.sh <netbiosname> <id>
#Matt Marshall 9-27-2005

#Prep
currency='$'
stationid=$1
#this gets the largest uid ignoring the nobody user(65556) then adds 1 to it
lastuid=`gawk -F: '{ print $3 }' /etc/passwd | sort -n | tail -2 | head -1`
newuid=$((lastuid+1))

#create usernamestring
if [[ ${stationid:((${#stationid}-1))} !=  $currency ]]
 then stationid=$stationid$currency
 else stationid=${stationid:0:((${#stationid}-1))}$currency
fi

susername=$stationid
echo $susername
#echo lines to passwd, shadow, group
echo "$susername:x:$newuid:$newuid::/dev/null:/sbin/nologin" >> /etc/passwd
echo "$susername:x:$newuid:" >> /etc/group
echo "$susername:!!:13053:0:99999:7:::" >> /etc/shadow

#create samba machine account
smbpasswd -amn $susername

#echo back modifications to screen
echo "Created $susername with $newuid for uid and guid"
echo "Modified password, shadow and group files"
tail -1 /etc/passwd ; tail -1 /etc/shadow ; tail -1 /etc/group


#EOF
