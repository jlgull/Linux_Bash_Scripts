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

#
# Start of Script
#
# Asks the user to input ten random words, which are to be stored 
#	in an array, named FirstArray.
# 	NOTE: Consider using a loop for this.
#

echo; echo "Please enter 10 random words for Array: FirstArray"; pause

	for ((i=0; i<10; i++))
	do
		
		echo; read -p "Enter random word # $(($i+1)) :-- " FirstArray[$i]
	
			if [[ $1 == "debug" ]]
			then 

				echo $i ${FirstArray[$i]} ; sleep 2; pause
		
			fi

	done

#
# Asks the user for five more random words, to be stored 
# 	in a different array, named SecondArray.
# 	NOTE: Consider using a loop for this.
#

echo; echo "Please enter 5 random words for Array: SecondArray"; pause

	for ((i=0; i<5; i++))
	do
		
		echo; read -p "Enter random word # $(($i+1)) :-- " SecondArray[$i]

			if [[ $1 == "debug" ]]
			then 

				echo $i ${SecondArray[$i]} ; sleep 2; pause

			fi

	done

#
# Displays the contents and length of both arrays.
#

echo; echo "Here is the content of the 2 arrays, as first entered."
echo; echo "FirstArray:  ${FirstArray[@]}"
echo; echo "SecondArray: ${SecondArray[@]}"

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

echo; echo "Please enter a sixth word, to be added to SecondArray."
echo; read -p "Enter your word now:-- " SecondArray[$((${#SecondArray[@]}))]

#
#
# Displays the contents and length of both arrays.
#

echo; echo "Here is the updated content of the 2 arrays, after changes were made."
echo; echo "FirstArray:  ${FirstArray[@]}"
echo; echo "SecondArray: ${SecondArray[@]}"

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

#
# End of file
#
#
