#!/bin/bash
#
# Written by Jonathan Heard for CIS239DL, Fall 2014
#
# Script to add users from the file: /root/users
# Assigning a generic password from file: /root/pwordfile
#
# Homework for week 3, due at class 4
#
# Clear the Screen prior to proceeding

clear

#Test for existance of User Name File (/root/users)

if [[ -f /root/users ]]
then

# Set counter to 0, to count the number of users added

	counter=0	

# If the User file exists then add the users to the system and
# then cat the tail of the /etc/passwd file to the Screen

	while read username
	do

# Increment the counter for each name read.

		(( counter++))

# Create the user name from the file /root/name
# copied from work done in class with Mike Maguire

		first=`echo $username | cut -d: -f1`
		firstc=${first:0:1}
		last=`echo $username | cut -d: -f2`

# Create a file for use during removal

		echo $firstc$last >> /root/removethese
		useradd $firstc$last
		passwd --stdin $firstc$last < /root/pwordfile
		echo "User account established for $username"
		echo
	done < /root/users
	echo "A total of $counter User accounts were established."

# After all Users are added, list out the tail of /etc/passwd

	echo
	cat /etc/passwd | tail -n $counter
	echo
else
# If the User file does not exist, the put out a message to create
# the User file.

	echo "Need to have users listed in file /root/users."
	echo "Content Layout: User First Name:User Last Name"
	echo "No spaces in the User Name List."
	exit

fi

exit

