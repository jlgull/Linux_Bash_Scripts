#!/bin/bash

clear

echo; echo "Please enter your first name:"
read FirstName

echo; read -p "Now enter your middle and last names: " MiddleName LastName

FullName="$FirstName $MiddleName $LastName"

echo; echo "The name entered was: $FullName"

echo

#
# End of file
#

