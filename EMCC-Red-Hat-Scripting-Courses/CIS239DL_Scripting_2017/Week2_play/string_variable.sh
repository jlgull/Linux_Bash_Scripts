#!/bin/bash
#
# Filename: string_variable.sh  
# Title: Show impact of using ' vs " quotes for Fall 2017 CIS239DL
# Author: Jonathan Heard
#
# Instructor: Tracy Baker
#
#
clear

cat string_variable.sh

Test_Var="this is a test variable (string)"

echo; echo "No quotes : " $Test_Var

echo; echo "Single quotes : " '$Test_Var'

echo; echo "Double quotes : " "$Test_Var"

echo
#
#
# End of file.
#
