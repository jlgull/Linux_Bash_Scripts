#!/bin/bash
#
# Filename: case.sh
# Author: Jonathan Heard
# Purpose: Examples of the use of the case command
#
#

clear; echo

read -p "Please choose an option (A - G): " Choice

echo

case $Choice in
	a|A) echo "Doing option A, your input $Choice" ;;
	b|B) echo "Doing option B, your input $Choice" ;;
	c|C) echo "Doing option C, your input $Choice" ;;
	d|D) echo "Doing option D, your input $Choice" ;;
	e|E) echo "Doing option E, your input $Choice" ;;
	f|F) echo "Doing option F, your input $Choice" ;;
	g|G) echo "Doing option G, your input $Choice" ;;
	*) echo "Your choice was not (A - G), your input $Choice" ;;
esac

echo

#
# End of file
#
