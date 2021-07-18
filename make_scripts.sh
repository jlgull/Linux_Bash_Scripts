#!/bin/bash
#
# Filename: make_scripts.sh
# Author: Jonathan Heard
#
# Purpose, to create an empty script shell.
#
clear; echo

read -p "Enter the name requested for the new script: " ScriptName

# Place the new script name in Script

Script=$ScriptName.sh

# Create the empty script shell.

echo "#!/bin/bash" > $Script
echo "#" >> $Script
echo "# Filename: $Script" >> $Script
echo "# Author: Jonathan Heard" >> $Script
echo "# Purpose: " >> $Script
echo "#" >> $Script
echo "#" >> $Script
echo >> $Script
echo >> $Script
echo >> $Script
echo "#" >> $Script
echo "# End of file" >> $Script
echo "#" >> $Script

# Make the new script executable.

chmod +x $Script

#
# Open the Vim editor in the new file.
#

vim +"set number" +5 $Script

#
# End of File
#
