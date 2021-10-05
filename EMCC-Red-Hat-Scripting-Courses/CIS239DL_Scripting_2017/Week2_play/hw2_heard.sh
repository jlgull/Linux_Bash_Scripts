#!/bin/bash
#
# Filename: hw2_heard.sh
# Title: Homework for week 2 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Use redirection to generate the required ouptput display.
#
#
# Start of Script
#
# Create the file required, using a variable File.

File="$HOSTNAME".txt

#
# Test and see if file exists, then
# remove the required file, if created previously during testing.

if [ -f $File ]
	then
	rm $File
fi

# 1. The first line in the file will be the user name of the currently logged on user.
# 
# Create the file name using the System's host name,
# while creating the file, push the user name in the first line.

echo $USER > $File

#
# 2. Append a blank line.
#
# Here is the blank line.

echo >> $File

#
# 3. Copy /etc/group to the directory you are working in – rename it group.bak.

cp /etc/group group.bak

#    Sort group.bak and append it to the file you are creating.

sort < group.bak >> $File

# 4.Append a blank line.
#
# Here is the blank line.

echo >> $File

# 5.Append positional parameters 0 (which is the script’s name) and 1 (your first name) in to the file.

echo "The script $0 was executed by $1!" >> $File

#
# Now for cleanup, remove the group.bak file from the working directory.
#

rm group.bak

#
# Finally display the results of the script using the less command.
#

less $File

#
# End of file
#
