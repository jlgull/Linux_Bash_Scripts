#!/bin/bash
#
# Filename: play.sh
# Author: Jonathan Heard
# Purpose: 
#
#
unset First

function FillArray
{
for ((i=0; i<$2; i++))
do

# echo $1 $2; sleep 3

read -p "Enter letters..." $1[$i]

done

}


FillArray First 3


# echo ${First[@]}
echo "Random words: ${First[@]} array length: ${#First[@]}"



#
# End of file
#
