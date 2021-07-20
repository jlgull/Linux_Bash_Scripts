#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Mon Oct 13 19:47:54 MST 2014
# Program for fall 2012 final exam, question 22

dirname=`pwd`
if [[ $dirname = "/" ]]
then
  echo "You are in the root directory."
elif [[ $dirname = "/tmp" ]]
then
  echo "You are in /tmp."
else
  echo "You are in neither root nor /tmp."
fi

