#!/bin/bash
#
# Filename: cut.sh
# Author: Jonathan Heard
# Purpose: show the use of the cut command.
#
clear; echo

echo; read -p "What is the name of the file you want to process? " File
echo; read -p "Which field(s), in $File, do you want to see? " Field
echo; read -p "How are the fields delimited? " Delimiter

echo; echo "$(cut $File -d$Delimiter -f$Field)"

echo

#
# End of file
#
