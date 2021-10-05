#!/bin/bash
#
# Filename: bash_math_modulo.sh
# Author: Jonathan Heard
# Purpose: Showing the use of modulo 
#
#

clear; echo

echo "The modulo operation returns the remainder from a division operation, "
echo "    not the quotient. "


echo; echo ">>> ((4%3)): "$((4%3))
echo; echo ">>> ((41%2)): "$((41%2))
echo; echo ">>> ((72%2)): "$((72%2))
echo; echo ">>> ((54%5)): "$((54%5))

echo; read -p "Paused... Press ENTER."
echo

#
# End of file
#
