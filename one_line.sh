#!/bin/bash
#
# Filename: one_line.sh
# Author: Jonathan Heard
# Purpose: One line script to find files owned by a user
#
# Original one line follows:
#  
# for FN in $(find / -user kiosk); do cp -a $FN /home/kiosk; done
#
# Establish variables
#

FileCount=0

#
clear

function FindFiles
{

for FN in $(find / -$1 $2 2> /dev/null)
do
	$3 $FN ~/tmpfound 2> /dev/null
	if [[ $? -eq 0 ]]
	then
	(( FileCount++ ))
	fi
done

}

function Pause
{

read -p "Press Enter to continue...."

}


#
# Make the tmpfound directory for use here.
#

mkdir ~/tmpfound

#
#

echo "This script can be used to locate all files for either"
echo "  a user or a group. There will be 2 questions to answer."
echo "  The first is which field to search on, User or Group; "
echo "  and the second is the name being searched for."
echo 
echo "Please select the field, enter either U for the user or"
read -p "  enter G for the group to be searched on: " FieldName

if [[ ($FieldName == "U") || ($FieldName == "u") ]]
then
	Type="user"
else
	Type="group"
fi

echo
read -p "Please enter the $Type name to search on: " Name

cp_mv="cp -a"

FindFiles $Type $Name $cp_mv

echo "$FileCount files were found."

Pause

ls -a ~/tmpfound | less

#
# End of file
#
