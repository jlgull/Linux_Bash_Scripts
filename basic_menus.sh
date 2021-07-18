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
# Generates a Fibonacci sequence, for 50 iterations. 
#	Beginning with 0.
#
# Determines if a number is odd or even, based on the user’s input.
#
# Has the user try to guess the number the computer has picked at random, 
#	1 to 10.
#	Consider searching Google to find out how to generate 
#	random numbers.
#
# Calculates the factorial of a number submitted by a user.
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
# Start of the 4 functions, 1 for each of the required tests.
#
function Fibonacci
{
        echo "Doing option A, your input $Choice"; sleep 3
}

function Odd/Even
{
        echo "Doing option B, your input $Choice"; sleep 3
}

function Random
{
        echo "Doing option C, your input $Choice"; sleep 3
}

function Factorial
{
        echo "Doing option D, your input $Choice"; sleep 3
}

#
# Start of Script
#
# Menu to select which of the 4 required Math based activities.
#

while :
do

clear

echo "Here are 4 different Math related activities that can be done with bash."
echo
echo "                        List of Activities"
echo
echo " A - Generates a Fibonacci sequence, for 50 iterations."
echo
echo " B - Determines if a number is odd or even, based on the user’s input."
echo
echo " C - To try to guess the number the computer has picked at random,"
echo "      between 0 and 10."
echo
echo " D - Calculate the factorial of a number submitted by a user."
echo
echo " Z - To end the Activities"
echo 
read -p "Enter your choice: " Choice

case $Choice in
        a|A) Fibonacci ;;
        b|B) Odd/Even  ;;
        c|C) Random    ;;
        d|D) Factorial ;;
        z|Z) echo "Thanks for playing!"; sleep 3; break ;;
        *) echo "Your choice was not (A - D or Z), your input $Choice"; sleep 3 ;;
esac

done
#
#
# End of file
#
