#! /bin/bash
#
# playing with (for looping)
read -p "enter start value for looping: " Start
read -p "enter end value for looping: " End
read -p "enter step value for looping: " Stepsize
for (( i=$Start; i>=$End; i+=$Stepsize))
do
	echo $i $Stepsize
done

