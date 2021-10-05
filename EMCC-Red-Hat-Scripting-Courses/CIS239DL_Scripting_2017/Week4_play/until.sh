#!/bin/bash
#
# Filename: until.sh
# Author: Jonathan Heard
# Purpose: Showing Until and while looping
#
#

clear; echo; echo "until loop"

x=10

until [ $x == 0 ]
do
	echo "x = $x"
	
	(( x-- ))

done

echo; echo; echo "while loop"

x=10

while [ $x != 0 ]
do
	echo "x = $x"

	(( x-- ))
done

echo

#
# Remember the Boolean NOT (!)?
# Tracy simply uses that instead of the until loop.
#
# End of file
#
