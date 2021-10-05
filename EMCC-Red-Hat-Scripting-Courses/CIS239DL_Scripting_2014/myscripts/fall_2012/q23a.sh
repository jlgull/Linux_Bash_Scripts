#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Mon Oct 13 20:20:43 MST 2014

# Program for fall 2012 final exam, question 23
# fixed to work and request the score.

# James scores a 62 on the CIS239 final and the value
# is stored in a variable called score.
# score=62

read -p "Enter the score received to determine your grade: " score

if [[ $score -ge 66 ]]
then
  echo "James got an A."
elif [[ $score -ge 33 ]]
then
  echo "James got a B."
else
  echo "James got less tha a B."
fi



