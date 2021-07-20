#!/bin/bash

clear; echo

## Get a number from the user. If the input includes characters other than numbers,
## or they simply press enter a number have them choose something valid.
## Entering Z causes the system choose a random number.
while :
do
    echo "Enter a decimal number, I will tell you how many binary ones are in it."
    read -p "(Z chooses a random number): " Number; echo

    case $Number in
        Z | z) Number=$RANDOM; echo "Using: "$Number; echo; sleep 3; break ;;
        *[!0-9]* | "" ) echo "Please enter a number!" ;;
        *) break ;;
    esac

done

## This strips any leading zeroes that may have been entered.
## (bash doesn't like leading zeroes when processing the number.)
## Make Input=$Number as we want an unchanged value for later output.
Number=$(echo $Number | sed 's/^0*//'); Input=$Number

## Checking to see if the user wants verbose mode, if the -v option wasn't used.
## The ${variable^^} construction forces the variable into uppercase.
Verbose="Y"
if [[ $1 != "-v" ]]
then
    read -p "Would you like verbose mode (Y for yes, anything else is no)? " Verbose
    echo; echo "In the future, you can activate verbose mode with: source One.sh -v"; echo
    Verbose=${Verbose^^}
fi

## Loop until Number=0 -- output information as it goes if Verbose=Y
Count=0
while [ $Number != 0 ]
do
    if [[ $Verbose == "Y" ]]
    then
        echo "Logically ANDing: "$Number" and "$((Number-1))
    fi

## Increment Count (we found a 1). Logically AND Number and Number-1, placing the
## result back into Number for next iteration
    ((Count++))
    Number=$((Number&((Number-1))))

    if [[ $Verbose == "Y" ]]
    then
        echo "Result          : "$Number
        echo "1s found so far : "$Count; echo
        echo "====================="; echo
    fi

done

## Output result
echo "There are "$Count" binary 1s in "$Input; echo

## Check for the existence of /usr/bin/bc -- if it exists, print binary number
## If it doesn't, tell user how to install bc, based on their Linux type
## (Debian or otherwise). NOTE: This will fail of /etc/os-release doesn't exist.
if [[ -f /usr/bin/bc ]]
then
    echo "The binary representation is: "$(echo "obase=2;$Input"| bc)
else
    Installer="yum"
    if [[ $(cat /etc/os-release) == *"debian"* ]]
    then
        Installer="apt-get"
    fi
    echo "If you install bc ("$Installer" -y install bc), the script will convert "$Input" into binary."
fi

echo
