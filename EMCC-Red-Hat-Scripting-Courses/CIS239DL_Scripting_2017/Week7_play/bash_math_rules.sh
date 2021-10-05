#!/bin/bash
#
# Filename: bash_math_02.sh
# Author: Jonathan Heard
# Purpose: Using basic math
#
# Using the bc - An arbitrary precision calculator language.
#
clear

echo "Using bc to get extended precision, not interger math."
echo '    for example: x=$(echo 'scale=6\;lenght=8\; 5/3' | bc)'

echo

x=$(echo 'scale=6;lenght=8; 5/3' | bc)

echo "Then x will equal: $x"

echo; echo "All bash math needs double (( ))"
echo "    for example: " 'a=$((1+1))'", there can't be any spaces."

a=$((1+1))

echo; echo "Then a will equal: $a"

echo

#
# End of file
#
