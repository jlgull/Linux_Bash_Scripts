#!/bin/bash
#
# Filename: infinite_loop.sh
# Author: Jonathan Heard
# Purpose: Example of an infinite loop
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
