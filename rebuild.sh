#!/bin/bash
#
# Filename: rebuild.sh
# Author: Jonathan Heard
# Purpose: Used to re-standardize the server and desktop VMs
#   	   This includes doing a reset of both VMs
#
# Clear the terminal, then start the script.
#

clear

#
# Command to reset both VMs
#

rht-vmctl reset all

#
# Begining of the resetting of the 2 VMs, no passwords are in
#	the script, so the work will have to be monitored.
#
# Doing the server VM first
#
# Pushing the /etc/hosts file from the foundation to server20.
#

echo;echo "Pushing hosts file to server20."

scp /etc/hosts root@server20:/etc/hosts

#
# Using ssh to change the root password. 
#	Interaction at server20 required.
#

echo;echo "Connecting to change root's password on server20."

ssh root@server20 

#
# Pushing the .bashrc from foundation20 root to server20, 
#	this will be to both root and student.
#

echo;echo "Pushing .bashrc file to root@server20."

scp /root/.bashrc root@server20:/root

echo;echo "Pushing .bashrc file to student@server20."

scp /root/.bashrc student@server20:/home/student

# 
# End of server20 work
#
#
# Doing the desktop20 VM first
#
# Pushing the /etc/hosts file from the foundation to server20.
#

echo;echo "Pushing hosts file to desktop20."

scp /etc/hosts root@desktop20:/etc/hosts

#
# Using ssh to change the root password. 
#	Interaction at desktop20 required.
#

echo;echo "Connecting to change root's password on desktop20."

ssh root@desktop20

#
# Pushing the .bashrc from foundation20 root to desktop20, 
#	this will be to both root and student.
#


echo;echo "Pushing .bashrc file to root@desktop20."

scp /root/.bashrc root@desktop20:/root

echo;echo "Pushing .bashrc file to student@desktop20."

scp /root/.bashrc student@desktop20:/home/student

#
# All updated are completed.

echo;echo "All updates to server20 and desktop20 are complete"

# 
# End of desktop20 work
#
#
# End of file
#
