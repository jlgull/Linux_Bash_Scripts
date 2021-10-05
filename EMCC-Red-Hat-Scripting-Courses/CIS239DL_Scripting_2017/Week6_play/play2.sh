#!/bin/bash
#
# Filename: play2.sh
# Author: Jonathan Heard
# Purpose: This is a 2nd try at how to use a function to pass
#	array name and count for how to fill an array.
#	This version does not work.
#
#
unset First

function FillArray
{


 
for i in {0..((\$2-1))}
do

echo $1 $2 $i; sleep 2

read -p "ssss" $1[$i]

done

}


FillArray First 5

echo ${First[@]}




#
# End of file
#
