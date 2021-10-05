#!/bin/bash
# 
# Filename: special_variable.sh
# Title: "Special" Variable examples for Fall 2017 CIS239DL
# Author: Jonathan Heard
#
# Instructor: Tracy Baker
#
#
clear

echo

j=0

echo; echo "This is script "$0". It is being executed by $USER."

# Test number of parameters to get grammer correct.

if [[ $# -eq 1 ]]

then

	echo; echo "$# argument has been passed to the script, they are: "

else

	echo; echo "$# arguments have been passed to the script, they are: "

fi

for i in $@

do
	echo "positional parameter $"$((++j))" is: $i"
done

echo; echo "Here are the arguments as a set: {$@}"

echo

#
#
# End of file.
#
