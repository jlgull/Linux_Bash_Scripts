#!/bin/bash
#
# Filename: bash_math_division.sh
# Author: Jonathan Heard
# Purpose: Showing Division
#
#

clear; echo

echo "Dividing numbers, no remainder ((4/2)): " $((4/2))

echo; echo "Dividing numbers, with remainder ((4/3)): "$((4/3))

echo; echo ">>> Remember: bash only handles Intergers."
echo "    With division only the quotient is returned!!"
echo "        The remainder is lost!!"

echo; read -p "Paused... Press ENTER."
echo

#
# End of file
#
