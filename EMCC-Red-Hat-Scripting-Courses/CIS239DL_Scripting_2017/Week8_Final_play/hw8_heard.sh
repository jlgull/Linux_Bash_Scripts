#!/bin/bash
#
# Filename: hw8_heard.sh
# Title: Homework for week 8 of CIS239DL, Fall 2017, Final Script.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Create a menu driven system of Administrator aids
#
#
# Create a script (hw8_{lastname}.sh) that uses a menu that allows an 
#	administrator to select from four options, each option is its 
#	own function in the script. 
#
#	For number 2 and number 4, create two text files with the same 
#	10 users (one to create, one to remove) in the formats specified.
#
# 1. Add a single user to the system using prompting
#	Asks admin for username, password, and account expiration date
#
#	Check for the existence of the user’s account BEFORE attempting 
#	to add it, and lets the administrator know if it already exists.
#
# 2. Add multiple users to the system, reading information from a text file.
#	The format is: username password expire_date
#
# 3. Removes a single user from the system using prompting
#	Asks administrator if home directories are to be removed
#
# 4. Removes multiple users to the system, reading information 
#	from a text file.
#
#	The format is: username REMDIR
#	If the keyword REMDIR is present, the user’s home directory is 
#	removed. If it is not, the home directory is kept.
#
#
# Start of Functions used in this script. 
#
# General use Functions used in ths script.
#
function pause
{

	echo; read -p "   The script is PAUSED... Press ENTER to continue"

}
#
#	There will be 2 Functions: One to ADD users and another to 
#	DELETE users. The functions can be used for either a single user
#	or for a list of users,
#
# Function to ADD users, will use the useradd command and several options.
#	In addition the getent will be used to verify that the added user
#	doesn't already exist in the system.
#
# The function will have 3 positional parameters:
#	$1 will be the user being added. (useradd is the command for
#		this part of the function.)
#	$2 will be the password being assigned. (chpasswd is the command that will
#		be used for this part of the function.)
#	$3 will be the account expiration date, the date format is
#		YYYY-MM-DD. (useradd -e, is the command for for this
#		part of the function.)
#
#
# This function can be called to add a user. It is used for adding one or many.
#

function AddUser
{ 

        echo "Info received by AddUser - User: $1, Password: $2, Expiration Date: $3 " >> ~/LogAdmin.txt


	if [[ $(grep "^\<$1\>" /etc/passwd) ]]
	then

		echo "User \"$1\" already exists and will not be added." >> ~/LogAdmin.txt
		echo >> ~/LogAdmin.txt
		(( Duplicate++ ))

	else

		echo "User \"$1\" is a new user and is being added" >> ~/LogAdmin.txt
		useradd -e$3 $1 &>> ~/LogAdmin.txt
		echo "$1:$2" | chpasswd  &>> ~/LogAdmin.txt
		echo >> ~/LogAdmin.txt
		(( Added++ ))

	fi

}

#
# Function to REMOVE users, will use the userdel command and several options.
#	In addition the getent will be used to verify that the added user
#	doesn't already exist in the system.
#
# The function will have 2 positional parameters:
#	$1 will be the user being removed. (userdel is the command for
#		this part of the function.)
#	$2 will an indicator regarding the removal of the user's home directory.
#		(userdel -r is the command for this part of the function.)
#
# This function can be called to remove a user. It is used for removing one or many.
#

function DelUser
{

        echo "Info received by DelUser - User: $1, Home Directory Flag: $2" >> ~/LogAdmin.txt

        echo "Removing User: $1 and Remove Home Directory Flag = $2" >> ~/LogAdmin.txt


	if [[ $(grep "^\<$1\>" /etc/passwd) ]]
	then

		echo "User \"$1\" is being removed from the system." >> ~/LogAdmin.txt
		echo >> ~/LogAdmin.txt

		if [[ $2 == "REMDIR" ]]
		then
			userdel -r $1 &>> ~/LogAdmin.txt
			(( Deleted++ ))
		else
			userdel $1 &>> ~/LogAdmin.txt
			(( Deleted++ ))
		fi

	else

		echo "User \" $1 \" is not in the system and can not be removed." >> ~/LogAdmin.txt
		echo >> ~/LogAdmin.txt
		(( Duplicate++ ))

	fi

}

#
# Start of Script
#
# Test to see if the user is root, if not exit script.
#
if [[ ($USER != "root") || ($USER == "") ]]
then
	echo; echo " This script must be run as root!"
	echo; echo
else

#
# Menu to select which Administrative function to perform.
# Using an infinite while loop to manage the menu process.
#
# Creating logging / information file ~/LogAdmin.txt
#

	echo "Users added from the file - $FileName " > ~/LogAdmin.txt
	echo "  Created $(date)" >> ~/LogAdmin.txt
	echo >> ~/LogAdmin.txt
			
	while :
	do

	clear

	echo; echo
	echo "   Here is a list of 4 different Linux Administrative Tools."
	echo
	echo "                           List of Tools"
	echo
	echo "    A - Add a single user, with prompts. Verify user is not in system."
	echo
	echo "    B - Add multiple users, from a data file."
	echo "        File format is - username:password:account expire date"
	echo
	echo "    C - Remove a single user, with prompts."
	echo
	echo "    D - Remove multiple users, based on data file."
	echo "        File format is - username:REMDIR"
	echo "        REMDIR is present if the user home directory"
	echo "            is being removed."
	echo
	echo "    Y - Review the content of ~/LogAdmin.txt, created during use of this "
	echo "        script, to review actions."
	echo
	echo "    Z - To Exit the Administrative Tools."
	echo 
	read -p "      Enter your choice: " Choice

	case $Choice in

        	a|A) # This choice will use prompts to add a single new user to the system.

			clear

			echo; echo "   This choice will request user information,"
			echo; echo "      and verifiy that the user does not already"
			echo; echo "      have an account on the system."
			echo; read -p "   Enter the user's name: " UName
			echo; read -p "   Enter the user's default password: " PassWord
			echo; echo    "   Enter the user's default expiration date,"
			echo; echo "      in this format YYYY-MM-DD  or "
			echo; read -p "      it blank to have no expiration date: " EDate

#			if [[ !$EDate =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]
			if [[ $EDate == "" ]]
			then
				EDate=99999
			fi

        		echo; echo "Info sent to AddUser - User: $UName, Password: $PassWord, Expiration Date: $EDate" >> ~/LogAdmin.txt
			echo "At $(date +"%X")" >> ~/LogAdmin.txt
			echo >> ~/LogAdmin.txt

# 
# Notes for testing date: if [[ !$EDate =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]
#

			AddUser $UName $PassWord $EDate

			;;
        
		b|B) # This choice will read a file and add all the users to the system.

			LinesRead=0
			Added=0
			Duplicate=0

			clear
	
			echo; echo "   This choice will ask for the file name"
			echo; echo "      containing the user information,"
			echo; echo "      and verifiy that the user does not already"
			echo; echo "      have an account on the system."
			echo; echo "      LogAdmin.txt created to show actions."
			echo; echo "   Enter the absolute path to the file "
			echo; read -p "      containing the users to be added: " FileName

			if [[ -f $FileName ]]
			then

				echo >> ~/LogAdmin.txt
				echo "Users added from the file - $FileName " >> ~/LogAdmin.txt
				echo "At $(date +"%X")" >> ~/LogAdmin.txt
				echo >> ~/LogAdmin.txt
			
				for Line in $(cat $FileName)
				do
					UName=$( echo $Line | cut -d: -f1)
					PassWord=$( echo $Line | cut -d: -f2)
					EDate=$( echo $Line | cut -d: -f3)

        				echo "Info sent to AddUser - User: $UName, Password: $PassWord, Expiration Date: $EDate" >> ~/LogAdmin.txt
					echo >> ~/LogAdmin.txt
					AddUser $UName $PassWord $EDate

					(( LinesRead++ ))
				done

				echo; echo "   There were $LinesRead entries in the file: $Filename."
				echo "      $Added Users were added to the system."
				echo "      $Duplicate Users in the file were already in the system."
				echo "      Use the Y option to review the LogAdmin.txt file created."
				pause

			else

				echo; echo "File \" $FileName \" does not exist."; pause

			fi
	
			;;

	        c|C) # This choice will use prompts to remove a single user from the system.

			clear

			echo; echo "   This choice will request user information,"
			echo; echo "      so the user can be deleted from the system."
			echo; echo "      If the user does not exist, then no further"
			echo; echo "      actions will be taken. If the account exists"
			echo; echo "      the the account will be removed."
			echo; read -p "   Enter the user's name: " UName
			echo; echo    "   Do you wish to remove the user's home"
			echo; read -p "      directory (Yes or No) : " Response

				case $Response in

				y|Y|YES|yes) REMDIR="REMDIR" 

				;;

				n|N|NO|no) REMDIR=""

				;;

				*) echo "Invalid response to Home Directory question.
                                           You answered $Response"
					sleep 3
				;;

				esac

				echo "Info sent to DelUser -  User: $UName, Home Directory Flag: $REMDIR" >> ~/LogAdmin.txt
				echo "At $(date +"%X")" >> ~/LogAdmin.txt
				echo >> ~/LogAdmin.txt

						DelUser $UName $REMDIR

			;;

		d|D) # This choice will read a file and remove all the users in the file from to system.

			LinesRead=0
			Deleted=0
			Duplicate=0

			clear

			echo; echo "   This choice will ask for the file name"
			echo; echo "      containing the users to be removed from the system,"
			echo; echo "      and verifiy that the user in in the system, it will"
			echo; echo "      not attempt to remove those with no account on"
			echo; echo "      on the system. LogAdmin.txt created to show actions."
			echo; echo "   Enter the absolute path to the file "
			echo; read -p "      containing the users to be removed: " FileName

			if [[ -f $FileName ]]
			then 

				echo "Users removed, based on the file - $FileName " >> ~/LogAdmin.txt
				echo "At $(date +"%X")" >> ~/LogAdmin.txt

				while read Line
				do

					UName=$( echo $Line | cut -d: -f1)
					REMDIR=$( echo $Line | cut -d: -f2)

					echo >> ~/LogAdmin.txt
					echo "Info sent to DelUser -  User: $UName, Home Directory Flag: $REMDIR" >> ~/LogAdmin.txt

						DelUser $UName $REMDIR

					(( LinesRead++ ))

				done < $FileName

				echo; echo "   There were $LinesRead lines in the file: $Filename."
				echo "      $Deleted Users were removed from the system."
				echo "      $Duplicate Users in the file were not in the system."
				echo "      Use the Y option to review the LogAdmin.txt file created."
				pause

			fi

			;;

	        y|Y) # This function allows for the review of the actions taken during execution.
		
			clear

			less ~/LogAdmin.txt 

			clear

			;;

	        z|Z) echo; echo "   Thanks for using these tools!"

			echo

			pause 

			clear; break

			;;

	        *) echo; echo "   Your choice was not (A - D or Y - Z). your input was $Choice."
			echo "      Please choose again."; echo; sleep 5

			;;

	esac

	done

fi

#
#
# End of file
#
