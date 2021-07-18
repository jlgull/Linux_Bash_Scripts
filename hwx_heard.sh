#!/bin/bash
#
# Filename: hwx_heard.sh
# Title: Homework for week x of CIS239DL, Fall 2017.
# Author: Jonathan Heard
# Instructor: Tracy Baker 
# 
# Purpose: Use uname command to create the following display.
#
# Kernal version   : XXXX
# (blank line)
# Operating system : XXXX
# (blank line)
# Architecture     : XXXX
#
# Start of Script
#
# Variable List (All variable names in UPPERCASE.)
# OS = the Operating System
# ARCH = Architecture of the system
# 
# Retrieve the Operating System information with uname -o and place in OS.
#
OS=$(uname -o)
#
# Retrieve the Architecture with uname -p and place in ARCH.
#
ARCH=$(uname -p)
#
# Build the output required.
#
clear
echo
echo
echo "Kernal version   : " $(uname -r)
echo
echo "Operating system : " $OS
echo
echo "Architecture     : " $ARCH
echo
echo
#
# End of file
#
