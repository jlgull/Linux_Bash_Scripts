#! bin.bash

Touch file.txt

While read LINE

do
	GID=$(echo $LINE | cut -d: -f3)
		if [[ $GID -lt 20 && $GID -gt 60 ]]
		then
			NAME=$(echo $LINE | cut -d: -f1)
			echo “$GID - $NAME” >> file.txt
		fi
	done < 

