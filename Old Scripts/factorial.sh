#! /bin/bash
#
# Written by Jonathan Heard for CIS239DL, Fall 2014
#
# Script to play/work with "for" loops

# Simple Factorial calculations, using "read" to get the values
#
# Clear the screen.
clear
#
# Set the factorial value to 1
Factorial=1
# Enter the value to calculate the Factorial of
read -p "Enter a value between 1 and 20 to calculate the Factorial of: " Input
#
# Test to see if Input is <= 20
if [ $Input -le 20 ]
then
# For Loop to calculate the requested Factorial

   for (( i=$Input; i>=2; i-- ))

   do
      ((Factorial=$Factorial*$i))
# Display each Factorial till requested value is calculated
# this is only for testing.
#      echo "The Factorial of $i is $Factorial"
   done 
# end of Loop Testing
# Display the requested number and its's factorial.
      echo "The Factorial of $Input is $Factorial"

else
   echo "You entered a value greater than 20."
fi

