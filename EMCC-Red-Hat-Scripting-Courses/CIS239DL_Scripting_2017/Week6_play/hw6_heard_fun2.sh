#!/bin/bash
#
# Filename: hw6_heard_fun.sh
# Title: Homework for week 6 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Use arrays to collect random words.
#
# Create a script (hw6_{lastname}.sh) that:
#
# Asks the user to input ten random words, which are to be stored 
#	in an array.
# 	NOTE: Consider using a loop for this.
#
# Asks the user for five more random words, to be stored 
# 	in a different array.
# 	NOTE: Consider using a loop for this.
#
# Displays the contents and length of both arrays.
#
# Asks the user for a word to be replaced in array #1, element #7
#
# Asks the user for a word to replace the 3rd word in array #2
#
# Asks the user to add a new word to the end of array #2
#
# Displays the updated contents and length of both arrays.
#
# Uses a nested loop to display the contents of both arrays, 
#	where array #2 is “inside” array #1
#
# Before any code starts, clear the screen.

clear

unset First

#
# Definition of Varialbles and assign initial values
#
#
# Define any functions required
#

function pause
{

	read -p "Process is paused, press 'Enter' to continue..."

}



function FillArray
{
#
# This function is expecting 2 (two) positional parameters.
# The first ($1) will be the name of the array to be filled.
# The second ($2) will be the number of items to be entered.
#
# Local variables

# local i=0

echo "Please enter $2 random words for Array  $1"

	for ((i=0; i<$2; i++))
	do
		
		read -p "Enter random word # $(($i+1)) :-- " $1[$1]


		echo $i; sleep 2

	done

}



FillArray First 3

echo "Random words: ${First[@]} array length: ${#First[@]}"

FillArray SecondArray 3

echo ${SecondArray[@]}


#
# Start of Script
#



#
# 
# End of file
#
