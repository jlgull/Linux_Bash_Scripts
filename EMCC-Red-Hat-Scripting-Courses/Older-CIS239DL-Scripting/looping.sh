#! /bin/bash
#
# Written by Jonathan Heard for CIS239DL, Fall 2014
#
# Script to play/work with "for" loops

# Simple Loop example, using "read" to get the values
#
clear
# Enter the loop Start value
read -p "Enter the Starting value for the loop: " start
# Enter the loop End value
read -p "Enter the Ending value for the loop: " end
# Enter the loop Step size
read -p "Enter the Step size for the loop: " step

if [[ $step -gt 0 ]]

then

for (( i=$start; i<=$end; i+=$step ))
do
echo $i
done

else

for (( i=$start; i>=$end; i+=$step ))
do
echo $i

# end of Loop Testing
done 

fi
