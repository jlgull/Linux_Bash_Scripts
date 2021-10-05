#!/bin/bash
#
# Filename: color_play.sh
# Author: Jonathan Heard
# Purpose: Learning to adjust bash color
#
#

NONE='\033[00m'
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[01;33m'
PURPLE='\033[01;35m'
CYAN='\033[01;36m'
WHITE='\033[01;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

Uline=${UNDERLINE}underlined${NONE}

Private=${BOLD}${RED}Private${NONE}
Public=${BOLD}${RED}Public${NONE}
Loopback=${BOLD}${RED}Loopback${NONE}
Multicast=${BOLD}${RED}Multicast${NONE}
Experimental=${RED}Experimental${NONE}


# echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and ${UNDERLINE}underlined${NONE}."

echo; echo -e "This text is ${RED}red${NONE} and ${GREEN}green${NONE} and ${BOLD}bold${NONE} and $Uline."

echo; echo -e "The IPV4 classes are: $Private, $Public, $Loopback, $Multicast and $Experimental"

echo

tput sgr0


#
# End of file
#
