#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Mon Oct 13 19:47:54 MST 2014
# Program for fall 2012 final exam, questiof 21

# mmaguire is the user logged in
if [[$HOME == "/mmaguire" ]]
then
  echo "red"
elif [[ $dirname == "/home/mmaguire" ]]
then
  echo "white"
else
  echo "blue"
fi

