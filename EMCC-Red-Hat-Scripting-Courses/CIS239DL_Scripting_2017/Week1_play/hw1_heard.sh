#!/bin/bash
#
# Filename: hw1_heard.sh
# Title: Homework for week 1 of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose, use uname command to create the following display.
#
# Kernal version   : XXXX
# (blank line)
# Operating system : XXXX
# (blank line)
# Architecture     : XXXX
#
# Start of Script
#
# Variable List (All variable names Start with UPPERCASE.)
# Os = the Operating System
# Arch = Architecture of the system
# 
# Retrieve the Operating System information with uname -o and place in Os.
#
Os=$(uname -o)
#
# Retrieve the Architecture with uname -p and place in Arch.
#
Arch=$(uname -p)
#
# Build the output required.
#
clear
echo
echo
echo "Kernal version   : " $(uname -r)
echo
echo "Operating system : " $Os
echo
echo "Architecture     : " $Arch
echo
echo
#
# End of file
#
#

