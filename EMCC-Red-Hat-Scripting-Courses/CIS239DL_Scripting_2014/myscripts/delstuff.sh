#!/bin/bash
#
# Written by Jonathan Heard for CIS239DL, Fall 2014
#
# Script to delete users from the system, information comes from
# the file /root/removethese


cat /root/removethese | while read text
do
	userdel -r $text
done

