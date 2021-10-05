#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Mon Oct 13 20:27:47 MST 2014

# Program for fall 2012 final exam, question 24

# Randy runs the following comand:

dayofweek=`date +%d`
  echo $dayofweek

if [[ $dayofweek == "Tue" ]]
then
  echo "Today is $dayofweek 10."
elif  [[ $dayofweek == "Mon" ]]
then
  echo "Today is $dayofweek 11."
else
  echo "Today is $dayofweek 10."
fi


