#!/bin/bash
#
# Filename: arrays_page_12.sh
# Author: Jonathan Heard
# Purpose: Bubble Sorting using an Array.
# 	Using the positional parameter "debug", enables the 
#	Function "pause".
#
# Global Variable initiation
#

Input=""; i=0; inc=0; skp=0; swp=0; unset NumberArray OriginalArray

#
# Function definitions
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

# Start of Code

clear

echo; echo "Please enter random whole (interger) numbers."

echo "Negative numbers, like -9, are fine."; echo

while :
do

	read -p "Press Enter to stop entering numbers: " Input

	if [[ $Input != "" ]]

	then

		OriginalArray[$((i++))]=$Input

if [[ $1 == "debug" ]]
then 

		echo "i=$((i-1)) and OA=${OriginalArray[$((i-1))]}"

fi

pause
		
		NumberArray[$((i-1))]=${OriginalArray[$((i-1))]}
		
if [[ $1 == "debug" ]]
then 

		echo "i=$i OA=${OriginalArray[$((i-1))]} NA=${NumberArray[$((i-1))]}"

fi

pause

	else

		break

	fi

done
		
if [[ $1 == "debug" ]]
then 

	echo; echo "Original Array order: ${OriginalArray[@]}"
	echo; echo "Number Array order: ${NumberArray[@]}"

fi

echo; pause 

echo

ArrayLength=$((${#NumberArray[@]}-1))

for ((j=0; j<$ArrayLength; j++))
do

	for ((k=0; k<$ArrayLength; k++))
	do
	
		Num1=${NumberArray[$k]}; Num2=${NumberArray[(($k+1))]}

		echo; echo "Comparison # $((++inc)) : $Num1 and $Num2"

		if [[ $Num1 -gt $Num2 ]]
		then
			echo "$Num1 > $Num2 SWAPPING..."
			temp=$Num1
			NumberArray[$k]=$Num2
			NumberArray[(($k+1))]=$temp
			((swp++))
		elif [[ $Num1 -eq $Num2 ]]
		then
			echo "$Num1 = $Num2 skipping..."
			((skp++))
		else
			echo "$Num1 < $Num2 skipping..."
			((skp++))
		fi

		sleep 1
		
	done

done

#
# Display the results, along with the count of iterations, skips and swaps
#

echo; echo "Original order: ${OriginalArray[@]}"

echo; echo "Sorted results: ${NumberArray[@]}"

echo; echo "Number of iterations: $inc"

echo; echo "Number of skips     : $skp"

echo; echo "Number of swaps     : $swp"

echo; echo

#
# End of file
#
