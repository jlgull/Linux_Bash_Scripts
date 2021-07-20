#!/bin/bash

# This script is used to combine and examine the outputs from the lastb command from all of the Linux servers
# located in South Mountain Community College's Cisco lab. examine an input file, It looks for IP addresses
# that are attempting to hack into the machine(s). Once an offending IP is found, a WHOIS is performed on the
# IP and the subnet to which the IP belongs is determined. Ultimately, it will generate a file - Subnets.list.temp -
# with the list subnets (and, sometimes, host addresses, if originating in the US).
# The Subnets.list.temp file can be used with the updateIPtablesALLPCs.sh and Execute scripts to update the iptables
# on all of SMCC's Cisco lab's Linux VMs using crontab.
# See updateIPtablesALLPCs.sh and hn.sh for notes as to their operation.
#
# Author : Tracy L Baker
# Contact: tracy.baker@southmountaincc.edu or tech@whatacharacter.net

# If the script was executed as 'source getSubnets.sh test', run in test mode.

TESTTEST=$1
if [[ $TESTTEST != "test" ]]
then
        echo; echo "If you intended to run this script in test mode, press CTRL-C in the next 30 seconds and use the"
        echo "syntax: source getSubnets.sh test"
        echo; echo "Otherwise, wait, and the script will run as intended (in crontab, most likely)."
        sleep 30; TEST=""
else
        rm -f /var/log/getSubnets.log
fi

# Initialize variables
updated=0; B="--BAD--> "; AF=", appending address ("; AB=") to Subnets.list.temp."

# Function to add network/CIDR information that will be used by other scripts to update iptables on all lab PCs
function AddToList() {

        if [[ $1 != "" ]]
        then
                updated=1
                echo; echo "Adding "$1" to Subnets.list.temp"
                echo $1 >> Subnets.list.temp
        fi
}

##### START MAIN SCRIPT #####

clear

# We're going to use the lastb command to generate lists of IP addresses that have had bad logins against the server

# Passwords that are going to be used by sshpass to log into the CIS126/238/239 and CIS133 servers
CIS126="ThisIsThePaSSword"
CIS133="ThisIsAnotherPa\$\$word"

# Make certain there aren't any old report files from the servers
rm -f ToBeBlocked.lastb*

# For 192.168.1.1, the local machine, get all logins -- root and all other accounts. This server is the "honeypot"
# and there aren't any student accounts to worry about
echo "Getting IPs from 192.168.1.1..."
lastb -w > Dot3.lastb

while read text
do
        IPaddress=$(echo $text | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort -n | uniq)
        if [[ $IPaddress == "" ]]
        then
                Dashed=$(echo $text | grep -Eo '[0-9]{1,3}\-[0-9]{1,3}\-[0-9]{1,3}\-[0-9]{1,3}' | sort -n | uniq)
                if [[ $IPaddress != "" ]]
                then
                        Paddress=${Dashed//-/.}
                fi
        fi
        if [[ $IPaddress != "" ]]
        then
                echo $IPaddress >> ToBeBlocked.lastb3
        fi
done < Dot3.lastb
rm -f Dot3.lastb

# Cycle through all the lab's servers, and look for bad logins against root, (to prevent getting bad student logins).
# This is done by executing a small script (LastBRemote.sh) on each machine to generate lists on each machine, then
# copy those lists back to .3
for (( address=40 ; address<52; address++))
do
        echo; echo "Executing LastBRemote.sh: 192.168.1."$address
        sshpass -p $CIS126 ssh root@192.168.1.$address 'bash -s' < LastBRemote.sh
        echo "Copying result file back to 192.168.1.1"
        sshpass -p $CIS126 scp root@192.168.1.$address:/root/ToBeBlocked.lastb /root/ToBeBlocked.lastb$address
done

# This block is specifically for 192.168.1.7
echo; echo "Executing LastBRemote.sh: 192.168.1.7"
sshpass -p $CIS133 ssh root@192.168.1.7 'bash -s' < LastBRemote.sh
echo "Copying result file back to 192.168.1.1"
sshpass -p $CIS133 scp root@192.168.1.7:/root/ToBeBlocked.lastb /root/ToBeBlocked.lastb7

# Combine all the lists from the server, and sort

cat ToBeBlocked.lastb* | sort -n | uniq > ToBeBlocked.list

#while read text
#do
#       if [[ $text != "" ]]
#       then
#               echo $text >> TBB.temp
#       fi
#done < ToBeBlocked.list
#rm -f ToBeBlocked.list; cat TBB.temp > ToBeBlocked.list; rm -f TBB.temp

# This loop reads through ToBeBlocked.list getting the subnets that will be blocked if the subnet in question isn't
# (1) whitelisted or (2) a US addresses. If it is a US addresses, the specific host addresses will be blocked.
echo; echo "Performing lookups for these IPs:"; echo; cat ToBeBlocked.list; echo

StartLog=1

while read suspectIP
do

# Initialize reusable variables
        SubNet=""; SubNet1=""; SubNet2=""; LookUp=""; TempIP=""; TempCIDR=""; CIDR=""; OrigString=""; Authority=""

# Perform a single lookup at the start of this loop and place results in WHOISlookup.report, which is used to search on
# (A much better, and faster, solution that looking up the information multiple times.)
        whois $suspectIP > WHOISlookup.report

# Get country code for ARIN, RIPE, AfriNIC, and APNIC addresses
        countryName=$(cat WHOISlookup.report | grep '[Cc]ountry:        ' | cut -d' ' -f9)

        if [[ $countryName != "" ]]
        then
# Certain responses for US addresses return multiple "US"s - like "US US US", if this occurs, change countryName variable to just
# US for later processing. Also, Process a few other common ones...
                if [[ $countryName == *"US"* ]]
                then
                        countryName="US"
                elif [[ $countryName == *"CN"* ]]
                then
                        countryName="China"
                elif [[ $countryName == *"RU"* ]]
                then
                        countryName="Russia"
                else
                        coutryName=""
                fi
        fi

# The next few blocks retrieve or calculate the network addresses and CIDRs that are used to iptables.

# Network/CIDR frm ARIN (North America) addresses
        if [[ $SubNet == "" ]]
        then
#               if [[ $(cat WHOISlookup.report | grep '# ARIN WHOIS') == *"ARIN"* ]]
                if [[ $(cat WHOISlookup.report) == *"ARIN"* ]]
                then
                        SubNet=$(cat WHOISlookup.report | grep CIDR | cut -d' ' -f12)
                        Authority="ARIN"

                        # This sub-block is to process ARIN addresses that return multiple subnets
                        Count=$(grep -o "/" <<<$SubNet | wc -l)

                        # This pulls the 1st two subnets, if there are at least two. At this time, only the
                        # first subnet is used.
                        if [[ $Count > 1 ]]
                        then
                                SubNet1=$(echo $SubNet | cut -d' ' -f1)
                                SubNet2=$(echo $SubNet | cut -d' ' -f2)
                                SubNet=$SubNet1
                        fi
                fi
        fi

# Network/CIDR from RIPE (Europe) addresses
        if [[ $SubNet == "" ]]
        then
#               LookUp=$(cat WHOISlookup.report | grep source:)
#               if [[ $LookUp == *"RIPE"* ]]
                if [[ $(cat WHOISlookup.report) == *"RIPE"* ]]
                then
                        SubNet=$(cat WHOISlookup.report | grep route: | cut -d' ' -f11)
                        Authority="RIPE"
                fi
        fi

# We must calculate the Network/CIDR for APNIC (Asia/Pacfic) and AFRINIC (Africa) addresses. NOTE: Some APINIC addresses
# report a range that produces an increment that doesn't exit -- for example, an increment of 3. In this case, the script
# will append the next lower classful boundary CIDR. In other words, if the weird increment would give a CIDR of /10.5
# a CIDR of /8 will be used.
        if [[ $SubNet == "" ]]
        then
#               LookUp=$(cat WHOISlookup.report | grep source:)
#               if [[ $LookUp == *"APNIC"* || $LookUp == *"A[Ff][Rr][Ii]NIC"* ]]
#               then

# REMOVE
#                       TempNetwork=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f9)
#                       TempBCast=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f11)
#                       Network=$(echo $TempNetwork | grep . | cut -d' ' -f1)
#                       BCast=$(echo $TempBCast | grep . | cut -d' ' -f1)
#                       Network=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f9 | cut -d' ' -f1)
#                       BCast=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f11 | cut -d' ' -f1)
#                       NetworkOctet1=$(echo $Network | cut -d. -f1); NetworkOctet2=$(echo $Network | cut -d. -f2)
#                       NetworkOctet3=$(echo $Network | cut -d. -f3); NetworkOctet4=$(echo $Network | cut -d. -f4)
#                       BCastOctet1=$(echo $BCast | cut -d. -f1); BCastOctet2=$(echo $BCast | cut -d. -f2)
#                       BCastOctet3=$(echo $BCast | cut -d. -f3); BCastOctet4=$(echo $BCast | cut -d. -f4)
#                        if [[ $BCastOctet4 != 255 ]]
#                        then
#                                Increment=$(((BCastOctet4+1)-NetworkOctet4)); ClassfulCIDR=24
#                        elif [[ $BCastOctet3 != 255 ]]
#                        then
#                                Increment=$(((BCastOctet3+1)-NetworkOctet3)); ClassfulCIDR=16
#                        else
#                               Increment=$(((BCastOctet2+1)-NetworkOctet2)); ClassfulCIDR=8
#                        fi


                if [[ $LookUp == *"APNIC"* || $LookUp == *"A[Ff][Rr][Ii]NIC"* ]]
                then
                        Network=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f9 | cut -d' ' -f1)
                        BCast=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f11 | cut -d' ' -f1)

                        for (( i=0; i<4; i++))
                        do
#                               TempNOct=$(echo $Network | cut -d. -f$((i+1)))
#                               NetOct[$i]=$TempNOct
#                               NetOct[$i]=$(echo $Network | cut -d. f$((i+1)))
#                               TempBCOct=$(echo $BCast | cut -d. -f$((i+1)))
#                               BCOct[$i]=$TempBCOct
#                               BCOct[$i]=$(echo $BCast | cut -d. -f$((i+1)))
                                BCOct[$i]=$(echo $BCast | cut -d. -f$((i+1)))
                                NetOct[$i]=$(echo $Network | cut -d. -f$((i+1)))
                        done

                        if [[ ${BCOct[3]} != 255 ]]
                        then
                                Increment=$((++BCOct[3] - NetOct[3])); ClassfulCIDR=24
                        elif [[ ${BCOct[2]} != 255 ]]
                        then
                                Increment=$((++BCOct[2] - NetOct[2])); ClassfulCIDR=16
                        else
                                Increment=$((++BCOct[1] - NetOct[1])); ClassfulCIDR=8
                        fi

                        case $Increment in
                                128) NetBits=1 ;; 64) NetBits=2 ;; 32) NetBits=3 ;; 16) NetBits=4 ;;
                                  8) NetBits=5 ;;  4) NetBits=6 ;;  2) NetBits=7 ;;  1) NetBits=8 ;;
                                  *) NetBits=0 ;;
                        esac
                        SubNet=$Network"/"$(($ClassfulCIDR+$NetBits))
                        OrigString=$(cat WHOISlookup.report | grep inetnum:)
                        Authority="AfriNIC"
                        if [[ $LookUp == *"APNIC"* ]]
                        then
                                Authority="APNIC"
                        fi
                fi




# KEEP FOR REPLACEMENT FOR ABOVE
#
#                       for (( i=0; i<3; i++))
#                       do
#                               TempNOct=$(echo $Network | cut -d. -f$((i+1)))
#                               NetOct[$i]=$TempNOct
#                               TempBCOct=$(echo $BCast | cut -d. -f$((i+1)))
#                               BCOct[$i]=$TempBCOct
#                       done
#
#
#
#                       if [[ ${BCOct[3]} != 255 ]]
#                        then
#                                Increment=(((${BCOct[3]}+1)-${NetOct[3]}))
#                               ClassfulCIDR=24
#                        elif [[ ${BCOct[2]} != 255 ]]
#                        then
#                                Increment=(((${BCOct[2]}+1)-${NetOct[2]}))
#                               ClassfulCIDR=16
#                        else
#                                Increment=(((${BCOct[1]}+1)-${NetOct[1]}))
#                               ClassfulCIDR=8
#                        fi

                        case $Increment in
                                128) NetBits=1 ;; 64) NetBits=2 ;; 32) NetBits=3 ;; 16) NetBits=4 ;;
                                  8) NetBits=5 ;;  4) NetBits=6 ;;  2) NetBits=7 ;;  1) NetBits=8 ;;
                                  *) NetBits=0 ;;
                        esac

                        SubNet=$Network"/"$(($ClassfulCIDR+$NetBits))
                        OrigString=$(cat WHOISlookup.report | grep inetnum:)
                        Authority="AfriNIC"
                        if [[ $LookUp == *"APNIC"* ]]
                        then
                                Authority="APNIC"
                        fi
                fi
        fi

# This is for from JPNIC (Japan) addresses, which do not return any way to determine the entirety of the subnet.
# Instead, the fourth octet will be replaced with a 0, and a /24 will be appended.
        if [[ $SubNet == '' ]]
        then
# REMOVE
#               if [[ $(cat WHOISlookup.report | grep JPNIC) == *"JPNIC"* ]]
                if [[ $(cat WHOISlookup.report) == *"JPNIC"* ]]
                then
                        for (( i=0; i<3; i++))
                        do
                                TempOct=$(echo $suspectIP | cut -d. -f$(($i+1)))
                                NetOct[$i]=$TempOct
                        done

                        SubNet=${NetOct[0]}"."${NetOct[1]}"."${NetOct[2]}".0/24"
                        countryName="Japan"
                        Authority="JPNIC (APNIC)"
                fi
        fi

# We must build the Network/CIDR from LACNIC (South America) addresses, as they're usually presented as 140.98/14
        if [[ $SubNet == "" ]]
        then
# REMOVE
#               if [[ $(cat WHOISlookup.report | grep lacnic) == *"lacnic"* ]]
                if [[ $(cat WHOISlookup.report) == *"[Ll][Aa][Cc][Nn][Ii][Cc]"* ]]
                then
                        countryName=$(cat WHOISlookup.report | grep '[Cc]ountry:     ' | cut -d' ' -f6)
# REMOVE
#                       TempIP=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f6)
#                       PartialNet=$(echo $TempIP | cut -d/ -f1)

                        PartialNet=$(cat WHOISlookup.report | grep inetnum: | cut -d' ' -f6 | cut -d/ -f1)
                        CIDR=$(echo $TempIP | cut -d/ -f2)
                        for (( i=0; i<4; i++))
                        do
                                TempOct=$(echo $PartialNet | cut -d. -f$(($i+1)))

                                if [[ $TempOct == "" ]]
                                then
                                        NetOct[$i]=0
                                else
                                        NetOct[$i]=$TempOct
                                fi
                        done

                        SubNet=${NetOct[0]}"."${NetOct[1]}"."${NetOct[2]}"."${NetOct[3]}"/"$CIDR
                        OrigString=$(cat WHOISlookup.report | grep inetnum:)
                        Authority="LACNIC"
                fi
        fi

# This is for some KORNET (Korea) addressess
        if [[ $SubNet == "" ]]
        then
# REMOVE
#               if [[ $(cat WHOISlookup.report | grep KORNET) == *"KORNET"* ||
#                        $(cat WHOISlookup.report | grep KRNIC) == *"KRNIC"* ]]
                if [[ $(cat WHOISlookup.report) == *"KORNET"* || $(cat WHOISlookup.report) == *"KRNIC"* ]]
                then
                        TempIP=$(cat WHOISlookup.report | grep 'IPv4 Address       :')
                        Network=$(echo $TempIP | cut -d' ' -f4)
                        TempCIDR=$(echo $TempIP | cut -d' ' -f7)
                        CIDR=$(echo $TempCIDR | cut -c2-4)
                        SubNet=$Network$CIDR
                        countryName="Korea"
                        Authority="KORNET/KRNIC (APNIC)"
                        OrigString=$TempIP
                fi
        fi

        echo
        echo "IP that was processed          = "$suspectIP
        if [[ $Authority == "APNIC" || $Authority == "AfriNIC" || $Authority == "LACNIC" || $Authority == "KORNET/KRNIC (APNIC)" ]]
        then
                echo "Network presentation           = "$OrigString
        fi
        echo "Blocked subnet (or host IP)    = "$SubNet
        echo "Country                        = "$countryName
        echo "Subnet authority               = "$Authority

# If there is no match against any authority, we want to know and block the host
        OK=0
        if [[ $SubNet == "" ]]
        then
                SubNet=$suspectIP; Authority="NONE - EXAMINE THIS IP ADDRESS!!"; countryName="Unknown"
        fi

# Whitelisted subnets
        if [[ $SubNet == "140.198.0.0/16" ||
                $SubNet == "68.96.0.0/12" ||
                $SubNet == "68.104.128.0/17" ]]
        then
                echo "--GOOD--> Found whitelisted address ("$suspectIP"), skipping..."; OK=1

# If the $SubNet variable remains greater then 18 characters long after previous processing, add the specific
# host address to list of addresses to be blocked
        elif [[ ${#SubNet} > 18 ]]
        then
                echo $B"The subnet is longer than 18 characters ("$SubNet")"$AF$suspectIP$AB" (country code="$countryName")"
                AddToList $suspectIP

# If the host address is in the US, add the specific host address to the list of addresses to be blocked
        elif [[ $countryName == "US" ]]
        then
                echo $B"US address"$AF$suspectIP$AB
                AddToList $suspectIP

# If the address is NOT from the US *and* the $SubNet variable remains empty from previous processing, add
# the specific host address to list of addresses to be blocked
        elif [[ $SubNet == "" ]]
        then
                echo $B"Non-US address (country code="$countryName") with no CIDR or route: entry"$AF$suspectIP$AB
                AddToList $suspectIP

# If the address is NOT from the US and the $SubNet variable has been filled, add the subnet in which
# specific host resides to the list of addresses to be blocked
        elif [[ $countryName != "US" ]]
        then
                echo $B"Non-US address ("$countryName")"$AF$SubNet$AB
                AddToList $SubNet
        fi

# Write to log file /var/log/getIP.log
        if [[ $StartLog == 1 ]]
        then
                echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"  >> /var/log/getSubnets.log
                echo ">>>>>>>>>> STARTING LOG FOR "$(date)" <<<<<<<<<<"  >> /var/log/getSubnets.log
                echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"  >> /var/log/getSubnets.log
        fi
        StartLog=0
        echo "---------------------------------------------------------" >> /var/log/getSubnets.log
        echo "Suspect IP address         : "$suspectIP >> /var/log/getSubnets.log
        if [[ $OrigString != "" ]]
        then
                echo "Original Network String    : "$OrigString >> /var/log/getSubnets.log
        fi
        echo "Address that was blocked   : "$SubNet >> /var/log/getSubnets.log
        if [[ $OK == 1 ]]
        then
                echo ">>>>>>>> WHITELISTED <<<<<<<<" >> /var/log/getSubnets.log
        fi
        echo "County code for IP address : "$countryName >> /var/log/getSubnets.log
        echo "---------------------------------------------------------" >> /var/log/getSubnets.log

done < ToBeBlocked.list

# Sort the list and place into Subnets.list.temp.sort and once sorted, put back into Subnets.list.temp
# for use with other scripts
cat Subnets.list.temp | sort -rn | uniq > Subnets.list.temp.sort
cat Subnets.list.temp.sort > Subnets.list.temp

# E-Mail administrator is any subnets were found
if [[ $updated == 1 ]]
then
        echo; echo "Sending Subnets.list.temp to administrator..."
        mail -s "ADDED: BLOCKED NETWORKS LOG" tracy.baker@southmountaincc.edu < /root/Subnets.list.temp
        echo; echo "Displaying Subnets.list.temp"; echo; cat Subnets.list.temp
else
        echo; echo "There were no updates at this time..."
fi

# Cleanup
# NOTE: test is passed to the script at the command prompt
if [[ $TESTTEST != "test" ]]
then
        rm -f Subnets.list.t; rm -f Subnets.list.temp.sort; rm -f WHOISlookup.report
        rm -f ToBeBlocked.list; rm -f ToBeBlocked.list.temp; rm -f ToBeBlocked.lastb*
        echo; echo "This script is NOT in test mode..."

# If not in test mode, reset /var/log/btmp on each machine by creating a psuedo-script file called RESET, execute the script
# on remote machines, then remove the RESET file, then reset /var/log/btmp on the local machine
        echo "cat /dev/null > /var/log/btmp" > RESET
        for (( address=40 ; address<52; address++))
        do
                echo; echo "Resetteting /var/log/btmp: 192.168.1."$address
                sshpass -p $CIS126 ssh root@192.168.1.$address 'bash -s' < RESET
        done
        # This block is specifically for 192.168.1.7
        echo; echo "Resetting /var/log/btmp: 192.168.1.7"
        sshpass -p $CIS126 ssh root@192.168.1.7 'bash -s' < RESET
        rm -f RESET
        cat /dev/null > /var/log/btmp
else

# If in test mode, update the local machine's iptables
        echo; echo "This script IS in test mode..."
        echo; echo "Adding to 192.168.1.1's iptables."
        iptables -F
        Counter=1
        while read SN
        do
                echo "Adding subnet number "$((Counter++))" - "$SN
                iptables -I INPUT -s $SN -j DROP
        done < Subnets.list.temp
        service iptables save
        systemctl restart iptables
        echo; echo "Displaying 192.168.1.1's iptables, INPUT chain only"; echo
        iptables -L INPUT
        echo; echo "/var/log/btmp was NOT reset on any machines."
fi

# Zero out the password variables so they don't stay in memory
CIS126=""
CIS133=""

echo; echo "Done."; echo
