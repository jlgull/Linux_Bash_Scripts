#!/bin/bash
#
# Filename: hw3_heard.sh
# Title: Homework for week 3 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Create a script that asks the user to input an IPv4 address. 
#
# It will then process that information and tell the user what class the IPv4 address is and 
#  whether it is a loopback, public or private address. 
#
# Additionally, no IPv4 address should begin with 0, 127. 
#
# No octet may have a value greater than 255. 
#
# Classes are determined by the first octet only. 
#
# Whether it is public or private will involve examining the first octet and, 
#  in some cases, the second.
#
# Given (where x is any number from 0 to 255):
#
#   Class A:  0 – 127     (private range is: 10.x.x.x)
#
#   Class B: 128 – 191    (private range is: 172.16.x.x – 172.31.x.x)
#
#   Class C: 192 – 223    (private range is: 192.168.x.x)
#
#   Class D (multicast): 224 – 239
#
#   Class E (experimental):  240 – 255 
#
#
# The script should be tested with the following addresses:
#
# Class A:   0.1.2.3 (invalid), 
#           10.0.0.1 (private), 
#           88.0.0.1 (public), 
#          127.0.0.1 (loopback)
#
# Class B: 172.18.0.1 (private),
#          172.32.0.1 (public)
#
# Class C: 192.168.0.1 (private), 
#          222.168.0.1 (public)
#
# Class D (multicast): 224.0.0.5
#
# Class E (experimental): 247.0.0.1
#
#
# Variable List (All variable names start with UPPERCASE.)
#
# IPAddress = The entered IPV4 address, being evaluated.
# Class = The Class of IPV4 address
# Type  = The type of IPV4 address, either loopback, public or private.
# Oct0  = The First Octet of the IPV4 address.
# Oct1  = The Second Octet of the IPV4 address.
# Oct2  = The Third Octet of the IPV4 address.
# Oct3  = The Fourth Octet, last Octet of the IPV4 address.
#
#
# Set up the options to allow for colored  display options 
# for a bash script echo line.
#

None='\033[00m'
Red='\033[01;31m'
Green='\033[01;32m'
Yellow='\033[01;33m'
Purple='\033[01;35m'
Bold='\033[1m'
Underline='\033[4m'

#
# Example showing how to use color in echo, the critical entry is the -e
# echo -e "An example: ${Red}red${None}"
#
#
# Start of Script
#
# Clear the screen and request the input of an IPV4 address to be
# evaluated for Class and Range.
#
clear

echo; echo; echo "Enter an IPV4 address in the clasic format xxx.xxx.xxx.xxx "
echo "Each of the numbers represented by, xxx , must have a value between "
read -p "the number 0 (zero) and 255. Enter here: " IPAddress

#
# Use the cut command to extract the 4 (four) Octets from the IPV4 address
# supplied and stored in IPAddress.
#
# First Octet
#

Oct0=$( echo $IPAddress | cut -d. -f1)

#
# Second Octet
#

Oct1=$( echo $IPAddress | cut -d. -f2)

#
# Third Octet
#

Oct2=$( echo $IPAddress | cut -d. -f3)

#
# Fourth Octet
#

Oct3=$( echo $IPAddress | cut -d. -f4)

#
# The following lines were for the testing runs.
#
# echo; echo "IPV4 Address is: $IPAddress"
#
# echo; echo "First Octet:  $Oct0"
#
# echo; echo "Second Octet: $Oct1"
#
# echo; echo "Third Octet:  $Oct2"
#
# echo; echo "Fourth Octet: $Oct3"

#
# Test the 4 (four) Octets to make sure they are not greater than 255.
#

if [[ Oct0 -le 255 && Oct1 -le 255 && Oct2 -le 255 && Oct3 -le 255 ]]
	then
	echo; echo "All the IPV4 Octet values are valid (less than 255)."

# 
# If a valid number, less than 255, was entered in all 4 (four) Octets,
# then determine Class and Type for the IPV4 address entered.
#
# Using if and elif test for the 5 (five) IPV4 Class addresses.
# Set Type to Public as a default and modify it where required.
#

	Type=Public

# Using if and elif to set the IPV4 Class
# 

	if [[ Oct0 -lt 128 ]]
	then
        	Class=A
        
	elif [[ Oct0 -lt 192 ]]
	then
        	Class=B

	elif [[ Oct0 -lt 224 ]]
	then
        	Class=C

	elif [[ Oct0 -lt 240 ]]
	then
        	Class=D ; Type=Multicast

	else
        	Class=E ; Type=Experimental

	fi


#
# Using if and elif to modify type for special cases
#

	if [[ Oct0 -eq 0 ]]
	then
		Type=Invalid

	elif [[ Oct0 -eq 10 ]]
	then
		Type=Private

	elif [[ Oct0 -eq 127 ]]
	then
		Type=Loopback

	elif [[ Oct0 -eq 172 && ( Oct1 -ge 16 && Oct1 -le 31 ) ]]
	then
		Type=Private

	elif [[ Oct0 -eq 192 && Oct1 -eq 168 ]]
	then
		Type=Private

	fi



#
# Display the results of the completed evaluation.
#

	echo; echo -e "Entered IPV4 address was: ${Red}$IPAddress${None}"

	echo; echo -e "Class: ${Red}$Class${None} IPV4 address and the Type is: ${Red}$Type${None}"

	echo; echo

#
# If any entered Octet is greater than 255, then display which Octet and the 
# entered value for that Octet.
 
elif [[ Oct0 -gt 255 ]]
then
	echo; echo -e "The First Octet value is greater than 255, entered value was ${Red}$Oct0${None}."

elif [[ Oct1 -gt 255 ]]
then
	echo; echo -e "The Second Octet value is greater than 255, entered value was ${Red}$Oct1${None}."

elif [[ Oct2 -gt 255 ]]
then
	echo; echo -e "The Third Octet value is greater than 255, entered value was ${Red}$Oct2${None}."

elif [[ Oct3 -gt 255 ]]
then
	echo; echo -e "The Fourth Octet value is greater than 255, entered value was ${Red}$Oct3${None}."

fi

#
# Reset the colors
#

tput sgr0

#
# End of file
#
