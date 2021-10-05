#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Fri Oct 10 22:26:34 MST 2014
# practice for quiz question 48
# Question about Case

dirname=$(pwd)

if [[ $dirname = "/" ]]
then
  echo "You are in the / directory."
elif [[ $dirname = "/tmp" ]]
  then
    echo "Your are in the /tmp directory."
  else
    echo "You are in neither root nor /tmp directory."
fi


