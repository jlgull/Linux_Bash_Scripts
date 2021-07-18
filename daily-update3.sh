#! /bin/bash

# Script to do daily updates using apt to update local list,
# then display list of items to update.
#
# This script must be run as root.
#
# This script was revised on 4/7/2021, by jlh, to have it run completely without interaction
#   and creates a log file on the desktop. Further testing will be required, when there is
#   new information. New information will be based on there actually being changes to be
#   made to the system.
#
# Create a Pause function, to be used instead of sleep.
#

function Pause
{

read -p "Update paused, press Enter to continue..."

}

# Assign log file to varialbe, to make changing it later easier.

LogFile=/home/jlh/.update/update.txt

# clear - used as part of manual version.
# Update is used to download package information from all configured sources. 
#	Other commands operate on this data to   e.g. perform package upgrades 
#	or search in and display details about all packages available for installation.
#

echo $'\n\n'$(date) $'\n' >> $LogFile

# echo; echo "apt-get -y update" # used as part of testing to see progress

echo $'\n'"Running update on the system."$'\n' >> $LogFile

apt-get -y update >> $LogFile

# List displays a list of packages satisfying certain criteria.
#	It supports glob(7) patterns for matching package names 
#	as well as options to list installed (--installed), 
#	upgradeable (--upgradeable) or all available (--all-versions) versions.

# echo "Skipping apt list --upgradeable" # used as part of testing to see progress

# echo; echo "Generating a list of upgrade-able files." >> /home/jlh/Desktop/update.txt # Pause

# apt list --upgradable >> /home/jlh/Desktop/update.txt

# Dist-upgrade in addition to performing the function of upgrade,
#	also intelligently handles changing dependencies with new versions
#	of packages; apt-get has a "smart" conflict resolution system, 
#	and it will attempt to 	upgrade the most important packages at the 
#	expense of less important ones if necessary. The dist-upgrade command 
#	may therefore remove some packages. The /etc/apt/sources.list file contains a 
#	list of locations from which to retrieve desired package files. 
#	See also apt_preferences(5) for a mechanism for overriding the general 
#	settings for individual packages.

# echo; echo "apt-get -y dist-upgrade" # used as part of testing to see progress

echo $'\n'"Running dist-upgrade to upgrade all available packages."$'\n' >> $LogFile

apt-get -y dist-upgrade >> $LogFile

# Perform cleanup
# Autoremove is used to remove packages that were automatically installed to satisfy 
#	dependencies for other packages and are now no longer needed as dependencies 
#	changed or the package(s) needing them were removed in the meantime.
#

# echo; echo "apt-get -y autoremove" # used as part of testing to see progress

echo $'\n'"Running the Autoremove command"$'\n' >> $LogFile

apt-get -y autoremove >> $LogFile

#
# Autoclean clears out the local repository of retrieved package files. 
#	It only removes package files that can no longer be downloaded, 
#	and are largely useless. This allows a cache to be maintained
#	over a long period without it growing out of control.
#

# echo; echo "apt-get -y autoclean" # used as part of testing to see progress

echo $'\n'"Running the Autoclean"$'\n' >> $LogFile

apt-get -y autoclean >> $LogFile

#
# Using updatedb to create or update a database used by locate(1).  
#	If the database already exists, its data is reused to avoid 
#	rereading directories that have not changed.
#

# echo; echo "updatedb" # used as part of testing to see progress

echo $'\n'"Running Updatedb"$'\n' >> $LogFile

updatedb >> $LogFile

# If there is a "reboot-required" entry, then
# display the results of cat  /run/reboot-required.pkgs
# to see why a reboot is required.

if [[ -f /run/reboot-required ]]
then

	echo >> $LogFile
        cat /run/reboot-required.pkgs >> $LogFile
	echo " Reboot required! " >> $LogFile

else

        echo " No reboot required. " >> $LogFile

fi

# End of run date and line

echo $'\n\n'$(date) $'\n' >> $LogFile

echo "* * * * * * * * * * * * * * * * * * * * * *" $'\n\n' >> $LogFile

# End of file
