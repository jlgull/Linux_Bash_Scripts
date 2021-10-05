#!/bin/bash
#
# Filename: hw6_heard.sh
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

#
# Definition of Varialbles and assign initial values
#
# FirstArray - will be the array used for the ten (10) random words.
# SecondArray - will be the array used for the five (5) random words.
# i - will be used for the counter for the filling both arrays.
# j & k - will be used for the counters for the nested loop at the
#	end of the script 
#
# Unset the 2 arrays, prior to each script execution.

unset FirstArray SecondArray

#
#
# Define any functions required
#

if [[ $1 == "debug" ]]
then 

	echo; echo "DEBUG is turned on!"; sleep 5

	function pause
	{
		read -p "System is paused, Press Enter to contiue..!"
	}
else

	function pause
	{
		local skip=0
	}

fi

function FillArray
{
#
# This function is expecting 2 (two) positional parameters.
# The first ($1) will be the name of the array to be filled.
# The second ($2) will be the number of items to be entered.
#
# Local variables

echo; echo "Please enter $2 random words for the Array: $1"

for ((i=0; i<$2; i++))
do

echo; read -p "Enter random word # $(($i+1)) :-- " $1[$i]

done

}

#
# Start of Script
#
# Asks the user to input ten random words, which are to be stored 
#	in an array, named FirstArray.
# 	NOTE: Consider using a loop for this.
#

FillArray FirstArray 10

#
# Asks the user for five more random words, to be stored 
# 	in a different array, named SecondArray.
# 	NOTE: Consider using a loop for this.
#

FillArray SecondArray 5

#
# Displays the contents and length of both arrays.
#

echo; echo "Here is the content of the 2 arrays, as first entered."
echo; echo "FirstArray contains $((${#FirstArray[@]})) words" 
echo; echo "	and here is the contents: ${FirstArray[@]}"
echo; echo "SecondArray contains $((${#SecondArray[@]})) words" 
echo; echo "	and here is the contents: ${SecondArray[@]}"
echo; echo; sleep 5

#
# Asks the user for a word to be replaced in array #1, element #7
#

echo; echo "Please enter a new word for Word 8 of FirstArray."
echo; echo "Currently Word 8 is ${FirstArray[7]}."
echo; read -p "Enter your word now:-- " FirstArray[7]

#
# Asks the user for a word to replace the 3rd word in array #2
#

echo; echo "Please enter a new word for Word 3 of SecondArray."
echo; echo "Currently Word 3 is ${SecondArray[2]}."
echo; read -p "Enter your word now:-- " SecondArray[2]

# Asks the user to add a new word to the end of array #2
#

echo; echo "Please enter an additional word, to be added to SecondArray."
echo; read -p "Enter your word now:-- " SecondArray[$((${#SecondArray[@]}))]

#
#
# Displays the contents and length of both arrays.
#

echo; echo "Here is the updated content of the 2 arrays, after changes were made."
echo; echo "FirstArray contains $((${#FirstArray[@]})) words" 
echo; echo "	and here is the contents: ${FirstArray[@]}"
echo; echo "SecondArray contains $((${#SecondArray[@]})) words" 
echo; echo "	and here is the contents: ${SecondArray[@]}"
echo; echo; sleep 5
#
#
# Uses a nested loop to display the contents of both arrays, 
#	where array #2 is “inside” array #1

for ((j=0; j<$((${#FirstArray[@]})); j++))
do
	for((k=0; k<$((${#SecondArray[@]})); k++))
	do
		echo "FirstArray Word $(($j+1)) is: ${FirstArray[$j]} & SecondArray Word $(($k+1)) is: ${SecondArray[$k]}"
	done
	echo; sleep 2
done
echo; echo; sleep 2
#
# End of file
#
#
