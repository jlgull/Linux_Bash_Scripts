#!/bin/bash
#
# Written by Jonathan Heard for CIS239DL, Fall 2014
#
# Script to delete users from the system, information comes from
# the file /root/removethese
# Clear the Screen
clear
echo " Deleting all users listed in /root/removethese"

cat /root/removethese | while read text
do
	userdel -r $text
done
echo

# Delete the removethese file
rm -f /root/removethese
echo " The /root/removethese file is now deleted:"
# 
# End of the script
exit
