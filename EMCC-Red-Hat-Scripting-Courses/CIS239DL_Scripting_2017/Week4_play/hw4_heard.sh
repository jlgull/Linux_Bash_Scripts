#!/bin/bash
#
# Filename: hw4_heard.sh
# Title: Homework for week 4 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Use looping to read a file and create the desired output.
#
# Variable List
#
# Entry = The extracted line from the passwd.bak file
# Uid = The User ID extractd from the passwd.bak file
# UName = The User Name extracted from the passwd.bak file
#
# Start of the script.
#
# Create 2 files for later use

echo > passwd_results.txt
echo "     Format" >> passwd_results.txt
echo "UID - User Name" >> passwd_results.txt
echo > tmp.txt

#
# Copy the /etc/passwd file into your working directory, rename it to passwd.bak
#

cp /etc/passwd passwd.bak

#
# Using a loop, read the passwd.bak file. Find UIDs greater than 9 and 
#  less than 40. When found, output the information to a file named 
#  passwd_results.txt
#
#	The information is to be formatted as: 
#     	UID - user name
#		Example:
#		29 - rpcuser
#		14 - ftp
#		12 - games
#
# Use a while loop to read each line and create the file tmp.txt
#

while read Entry # in  $(cat passwd.bak)
do

	Uid=$(echo "$Entry" | cut -d: -f3)

	if [[ $Uid -gt 9 && $Uid -lt 40 ]]
	then
		UName=$(echo $Entry | cut -d: -f1)
		echo " $Uid - $UName" >> tmp.txt
	fi
done < passwd.bak

#
# Reverse sort the file and append the results to passwd_results.txt
#

sort -rn < tmp.txt >> passwd_results.txt

# Using the less command, display passwd_results.txt to make certain that 
#	only users with UIDs greater than 9 and less than 40 are displayed
#	and that the list is reverse sorted.

less passwd_results.txt

#
# If the script runs multiple times, do NOT allow any information to be
#	appended to passwd_results.txt
#
#
# Delete passwd.bak and any other files (except passwd_results.txt) 
#	that you may have used.
#
# 

rm tmp.txt ; rm passwd.bak

#
# End of file
#
