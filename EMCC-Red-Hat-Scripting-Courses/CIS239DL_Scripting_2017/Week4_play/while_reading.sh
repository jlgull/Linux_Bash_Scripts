#!/bin/bash
#
# Filename: while_reading.sh
# Author: Jonathan Heard
# Purpose: Using a while loop to read and manipulate a file
#
#

clear

echo; read -p "What is the name of the file you want to read? " File

echo; read -p "Which field in $file do you want to 'pull'? " Field

echo; read -p "How are the fields delimited? " Delimiter

echo 

while read Line
do
	echo $(echo $Line | cut -d$Delimiter -f$Field)

done < $File

echo

#
# End of file
#
