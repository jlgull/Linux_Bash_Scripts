#!/bin/bash
#
# Filename: interger_test.sh
# Author: Jonathan Heard
# Purpose: Display the limits of Interger valuses.
#
#
clear

echo; echo "16 bit integer limit, x = 2^16."

echo; ((x=2**16)); echo "$x <-- okay, at least UInt16" 

echo; echo "32 bit integer limit, x = 2^32."

echo; ((x=2**32)); echo "$x <-- okay, at least UInt32"

echo; echo "64 bit integer limit, x = 2^64."

echo; ((x=2**64)); echo "$x <-- oops, not UInt64"

echo; echo "Actual 64 bit integer value, x = (2^63)-1."

echo; ((x=(2**63)-1)); echo "$x <-- okay, at least SInt64"

echo; echo "16 bit integer limit, x = (2^63) +1."

echo; ((x=(2**63)+1)); echo "$x <-- overflowed and wrapped negative. Must be SInt64"

echo; echo

#
# End of file
#
