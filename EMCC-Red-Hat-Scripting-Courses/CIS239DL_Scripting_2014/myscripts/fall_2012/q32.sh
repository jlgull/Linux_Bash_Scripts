#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Mon Oct 13 20:52:15 MST 2014

# Program for fall 2012 final exam, question 32

((z=5))
  echo $z
  sleep 3

((b=$z))
  echo $b
  sleep 3

((t=$b-4))
  echo $t
  sleep 3

while [[ $t -le 3 ]]

do
  echo "JAM"

done




