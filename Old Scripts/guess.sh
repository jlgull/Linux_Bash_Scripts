#!/bin/bash
# Guess a random number. While loop will keep things going.
read -p "Guess a number between 1 and 10: " guess
rand=$RANDOM
while true
do
if [[ $rand -ge 1 && $rand -le 10 ]]
then
    if [[ $guess -eq $rand ]]
    then
        echo "RIGHT!!"
        break 
    else
        echo "WRONGO!, Try again."
        read -p "Guess a number between 1 and 10:" guess
        rand=$RANDOM
     fi
else   
     rand=$RANDOM
fi
done    
