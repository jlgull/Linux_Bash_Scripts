#!/bin/bash
#
# Filename: bash_math_04.sh
# Author: Jonathan Heard
# Purpose: Showing various Subtraction methods
#
#

clear; echo

echo "Subtracting numbers ((1-2-3)): " $((1-2-3))
echo

echo; echo "Decrementing a number by one, three ways (using i=3):"

i=3;echo ">>> (($i-1)): $(($i-1))"
echo

i=3; echo ">>> ((i--)) -- print value for i BEFORE increment: "  $((i--))"; afterwards, i is "$i
echo

i=3; echo ">>> ((--i)) -- print value for i AFTER increment: "  $((--i))
echo

read -p "Paused... Press ENTER."
echo

#
# End of file
#
