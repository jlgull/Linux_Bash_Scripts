#! /bin/bash

# Script to do daily updates using apt to update local list,
# then display list of items to update.
#
#
# Create a Pause function, to be used instead of sleep.
#

function Pause
{

read -p "Update paused, press Enter to continue..."

}



clear
# Update is used to download package information from all configured sources. 
#	Other commands operate on this data to   e.g. perform package upgrades 
#	or search in and display details about all packages available for installation.
#

echo; echo "Running update on the system."; echo; Pause

sudo apt update

# List displays a list of packages satisfying certain criteria.
#	It supports glob(7) patterns for matching package names as well as options 
#	to list installed (--installed), upgradeable (--upgradeable) or all available (--all-versions) versions.

echo; echo "Generating a list of upgrade-able files."; echo; Pause

apt list --upgradable

# Dist-upgrade in addition to performing the function of upgrade, also intelligently handles changing dependencies 
#	with new versions of packages; apt-get has a "smart" conflict resolution system, and it will attempt to 
#	upgrade the most important packages at the expense of less important ones if necessary. 
#	The dist-upgrade command may therefore remove some packages. The /etc/apt/sources.list file contains a 
#	list of locations from which to retrieve desired package files. See also apt_preferences(5) for a 
#	mechanism for overriding the general settings for individual packages.

echo; echo "Running dist-upgrade to upgrade all available packages."; echo; Pause

sudo apt dist-upgrade

# Perform cleanup
# Autoremove is used to remove packages that were automatically installed to satisfy dependencies for 
#	other packages and are now no longer needed as dependencies changed or the package(s) needing 
#	them were removed in the meantime.
#

echo; echo "Running the Autoremove command"; echo; Pause

sudo apt autoremove

#
# Autoclean clears out the local repository of retrieved package files. It only removes package files 
#	that can no longer be downloaded, and are largely useless. This allows a cache to be maintained
#	over a long period without it growing out of control.
#

echo; echo "Running the Autoclean"; echo; Pause

sudo apt autoclean

#
# Using updatedb to create or update a database used by locate(1).  If the database already exists,
#	its data is reused to avoid rereading directories that have not changed.
#

echo; echo "Running Updatedb"; echo; Pause

sudo updatedb

# If there is a "reboot-required" entry, then
# display the results of cat  /run/reboot-required.pkgs
# to see why a reboot is required.

if [[ -f /run/reboot-required ]]
then

	echo
        cat /run/reboot-required.pkgs
	echo; echo " Reboot required! "; echo

else

        echo " No reboot required. "; echo

fi

# End of file
