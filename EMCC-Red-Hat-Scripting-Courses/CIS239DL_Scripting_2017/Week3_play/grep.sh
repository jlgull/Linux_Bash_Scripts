#!/bin/bash
#
# Filename: grep.sh
# Author: Jonathan Heard
# Purpose: Show the use of grep
#
clear; echo

Found=$(grep '/sbin/nologin$' /etc/passwd)

echo "Raw Results"

echo; echo "$Found"

echo; echo "Sorted Results"

echo; echo "$Found" | sort

echo

#
# End of File
#
