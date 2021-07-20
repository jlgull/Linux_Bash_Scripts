#! /bin/bash
# Jonathan Heard for CIS239DL Fall 2014
# Fri Oct 10 22:11:36 MST 2014
# Fall 2009 final Q? 33
# set -xv
((z=5))
echo $z
((b=$z))
echo $b
((t=$b-4))
echo $t
while [[ $t -le 3 ]]
do
((t++))

echo "JAM $t "

done



# set +xv
