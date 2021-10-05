#!/bin/bash
#
# Filename: bash_math_03.sh
# Author: Jonathan Heard
# Purpose: Showing various Addition methods
#
#

clear; echo

echo "Adding numbers ((1+2+3)): " $((1+2+3))
echo

echo; echo "Incrementing a number by one, three ways (using i=0):"

i=0;echo ">>> (($i+1)): $(($i+1))"
echo

i=0; echo ">>> ((i++)) -- print value for i BEFORE increment: "  $((i++))"; afterwards, i is "$i
echo

i=0; echo ">>> ((++i)) -- print value for i AFTER increment: "  $((++i))
echo

read -p "Paused... Press ENTER."
echo

#
# End of file
#
