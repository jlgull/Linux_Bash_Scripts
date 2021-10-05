#!/bin/bash
#
# Filename: hw7_heard.sh
# Title: Homework for week 7 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Use Bash Math commands to do the following 4 activities.
#
# Create a script (hw7_{lastname}.sh) that:
#
# 1. Generates a Fibonacci sequence, for 50 iterations. 
#	Beginning with 0.
#
# 2. Determines if a number is odd or even, based on the user’s input.
#
# 3. Has the user try to guess the number the computer has picked,
#	 at random between 1 to 10.
#	Consider searching Google to find out how to generate 
#	random numbers.
#
# 4. Calculates the factorial of a number submitted by a user.
#
# 	A factorial is a number multiplied by every number less than the 
#	one given. It is expressed as number!
#
#	For example: 4! is 4*3*2*1 (it equals 24).
#		NOTES:
#	The greatest factorial that bash can handle is 20!
#	Only positive numbers can be factorialized.
# 	There is no reason to factorialize 0 or 1.
#
# As there are four parts, you might want to consider using a menuing 
#	system and even functions!
#
# Start of the functions, 1 for each of the required tests. 
# Plus any other functions needed to complete the work.
#
# The pause function is used to show steps or reveal information during
#	the execution of the various scripts.
#
function pause
{

	echo; read -p "    The script is paused... press ENTER to continue."

}
#
function Fibonacci
{

# Option A - Generates a Fibonacci sequence, for 50 iterations. 
#       Beginning with 0.

	local A B C i

	clear; echo
	echo "   This Fibonacci generator will perform 50 iterations."
	echo "      The sequence will begin at 0 (zero)."
	pause

	A=0; B=1
	for i in {1..50}
	do

		if [[ ( $i -eq 1 ) ||  ( $(( ($i-1)%5 )) -eq 0  && $i -lt 50 )  ]]
		then

			echo; sleep 3 
			echo "   Iteration number followed by the 2 values used"
			echo "      to generate the Fibonacci number."
			echo

		fi
		
		((C=A+B))

		echo "   Iteration #: $i, $A, $B, $C"

		A=$B; B=$C

	done
	
	pause
}

function Odd/Even
{

#
# Option B - Determines if a number is odd or even, based on the user’s input.
#

	local Number

	clear; echo

	echo "   Enter a number and the script will "
	read -p "      tell you if the number is Odd or Even: " Number

	if [[ $(( $Number%2 )) -eq 0 ]]
	then

		echo; echo "   $Number is Even"
		echo; sleep 2

	else

		echo; echo "   $Number is Odd"
		echo; sleep 2

	fi

}

function Random
{
# Option C - Has the user try to guess the number the computer has picked,
#        at random between 1 to 10.

	local RandomNumber Guess

	RandomNumber=$(( $RANDOM%10 + 1 ))

	clear; echo; echo
	echo "   The computer has picked a number between 1 and 10."
	echo; read -p "      Please enter your guess within that range: " Guess

	if [[ ( $Guess -lt 1 ) || ( $Guess -gt 10 ) ]]
	then

		echo; echo "   Your guess was either less than 0 or "
		echo "      was greater than 10."
		echo; sleep 2

	else

		if [[ $RandomNumber -eq $Guess ]]
		then

			echo; echo "   Great guess, you were right."; sleep 2

		elif [[ $RandomNumber -gt $Guess ]]
		then

			echo; echo "   Sorry your guess was to small."; sleep 2

		else

			echo; echo "   Sorry your guess was to large."; sleep 2

		fi 

	echo; echo "   The computer picked $RandomNumber and you guessed $Guess"

        sleep 3

	fi

}

function Factorial
{

# Option D - Calculates the factorial of a number submitted by a user.

	local Input i Factorial=1

	clear; echo; echo
	echo "   The computer will calculate the Factorial of the number"
	echo "      you enter. Please enter a number between 2 and 20. "
	echo; read -p "      Please enter within that range: " Input

	if [[ ( $Input -lt 2 ) || ( $Input -gt 20) ]]
	then

		echo; echo "   Your number was either less than 2 or "
		echo "      was greater than 20."
		echo; echo "      Your number was: $Input "; echo; sleep 2

	else 
		
		echo; echo "   The calculations needed to reach $Input! follow:"
		echo

		for (( i=2; i<$Input+1; i++ ))
		do

			(( Factorial=$Factorial*$i ))

			if [[ $i -lt 10 ]]
			then

				echo "    $i! = $Factorial"	

			else

				echo "   $i! = $Factorial"

			fi
		
		done

		echo; echo "   Your request: $Input! = $Factorial "
		echo; pause 

	fi

}

#
# End of Functions
#
#
# Start of Script
#
# Menu to select which of the 4 required Math based activities.
#

while :
do

clear

echo; echo
echo "   Here are 4 different Math related activities that can be done with bash."
echo
echo "                           List of Activities"
echo
echo "    A - Generates a Fibonacci sequence, for 50 iterations."
echo
echo "    B - Determines if a number is odd or even, based on the user’s input."
echo
echo "    C - To try to guess the number the computer has picked at random,"
echo "        between 0 and 10."
echo
echo "    D - Calculate the factorial of a number submitted by a user."
echo
echo "    Z - To end the Activities"
echo 
read -p "   Enter your choice: " Choice

case $Choice in
        a|A) Fibonacci ;;
        b|B) Odd/Even  ;;
        c|C) Random    ;;
        d|D) Factorial ;;
        z|Z) echo; echo "   Thanks for playing!"; 
		echo; sleep 3; break ;;
        *) echo; echo "   Your choice was not (A - D or Z), your input was $Choice."; 
		echo "      Please choose again."; echo ; sleep 3 ;;
esac

done
#
#
# End of file
#
