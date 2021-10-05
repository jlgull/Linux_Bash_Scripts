#!/bin/bash
#
# Filename: hw5_heard.sh
# Title: Homework for week 5 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Create a script (hw5_{lastname}.sh) that:
#
# Use debug, after the script name to show debug echo commands.
#
# 1.Creates an alias named  l; command being aliased is less; 
#	command option = display line numbers
#
# 2.Copies /etc/shadow to your working directory, renaming it shadow.bak.
#
# 3.Changes the permissions on shadow.bak to: rw-rw----
#
# 4.Uses a function to read shadow.bak. The function will create a file
#	call shadow.unexpiring that:
#
#	1.Has the following as the first line :
#		 >>> Users with unexpiring passwords <<<
#
#	2.Determines the users with unexpiring passwords and 
#		appends them to the file
#
#	3.REQUIRED: Any variables used in the function must be defined as local
#
# 5.Deletes shadow.bak and any other temporary file(s) you may use.
#
# 6.Uses the alias created in step 1 to read the file.•Usage: l {filename}
#
# 7.shadow.unexpiring needs to be (re)created new each time the script
#	is executed.
#
#
# Clear the le alias, using the unalias command,
# 	in case there was another assigned le alias.
#

unalias le

#
# Variable used with the script
#
# SourceFile: will be the Source file to be copied for future manipulations
# BackFile: will be the copy of the Source file being manipulated
# ResultsFile: will contain the non-expiring users accounts
 
if [[ $1 == "debug" ]]
then
	echo; echo "Creating the 3 files used"; sleep 3
fi

SourceFile=/etc/shadow
BackFile=~/shadow.bak
ResultsFile=~/shadow.unexpiring
 
#
# For the first step, I will be using le not l for the alias. 
#	This is because I have an alias in my .bashrc on all my computers,
#	 which is defined as 'ls -al'.
#
# 1.Creates an alias named  le; command being aliased is less; 
#	command option = display line numbers. Using the man page for less,
#	determined the option needed was -N.

if [[ $1 == "debug" ]]
then
	echo; echo "Creating the alias"; sleep 3
fi

alias le='less -N'

#
# Display alias, to verify that the alias command worked to create
#	the alias le.
#
# echo; echo; alias
#
#
# Begining of Script for this homework.
#
# This script must be run as root, test that the user is root.
#

if [[ $USER != "root" ]]
then
	echo; echo "This script must be run with sudo or as root,"
	echo; echo 
else

#
# 2.Copies /etc/shadow to your working directory, renaming it shadow.bak.
#


	if [[ $1 == "debug" ]]
	then
		echo; echo "Coping $SourceFile to $BackFile"; sleep 3
	fi
	
	cp -f $SourceFile $BackFile

#
# 3.Changes the permissions on shadow.bak to: rw-rw----
#

	if [[ $1 == "debug" ]]
	then
		echo; echo "Using chmod to modidy $BackFile"; sleep 3
	fi

	chmod 660 $BackFile

#
# 4.Uses a function to read shadow.bak. The function will create a file
#	called shadow.unexpiring that:
#
#	3.REQUIRED: Any variables used in the function must be defined as local
#
#
#	1.Has the following as the first line :
#		 >>> Users with unexpiring passwords <<<

	if [[ $1 == "debug" ]]
	then
		echo; echo "Creating the function ReadShadow"; sleep 3
	fi

	function ReadShadow
	{
		echo ">>> Users with unexpiring passwords <<<" > $ResultsFile

#
#	2.Determines the users with unexpiring passwords and 
#		appends them to the file
#		From reading the man page (man 5 shadow), I determined that if 
#			the 8th field is an empty field, this means that the account 
#			will never expire.
#
#	3.REQUIRED: Any variables used in the function must be defined as local
#
# Use a local variable line, for the while loop
#
		local line

		while read line
		do
			if [[ ($(echo $line | cut -d: -f5) == "")
				|| ($(echo $line | cut -d: -f5) == "99999") ]]          
			then
				echo $(echo $line | cut -d: -f1) >> $ResultsFile
			fi

		done < $BackFile

	}

	if [[ $1 == "debug" ]]
	then
		echo; echo "Running the function ReadShadow"; sleep 3
	fi

	ReadShadow 

# 5.Deletes shadow.bak and any other temporary file(s) you may use.

	if [[ $1 == "debug" ]]
	then
		echo; echo "Deleting all files created, except shadow.unexpiring"; 
		sleep 3
	fi

	rm $BackFile


#
# 6.Uses the alias created in step 1 to read the file.•Usage: l {filename}
#

	clear

	le $ResultsFile


#
# 7.shadow.unexpiring needs to be (re)created new each time the script
#	is executed.
#
 
rm $ResultsFile

#
#

fi

#
# End of file
#
