#!/bin/bash
#
# Filename: while_menus.sh
# Author: Jonathan Heard
# Purpose: Using a while loop with a menu
#
#

clear

while :
do
	echo; echo "Please choose from one of the following:"
	echo "A) Apples"; echo "B) Beets"; echo "C) Carrots"
	echo; echo "Z) Quit the script."
	read -p ": " Choice
	echo

	case $Choice in
		a | A) echo "You picked Apples." ;;
		b | B) echo "You picked Beets." ;;
		c | C) echo "You picked Carrots." ;;
		z | Z) echo "You chose to quit." ; break ;;
		*) echo "Error: Please choose A, B, C or Z!" ;;
	esac

done

echo; echo "Goodbye"; echo

#
# End of file
#
