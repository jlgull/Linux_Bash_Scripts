# !/bin/bash
# Jonathan Heard March 26, 2014
# Check logins
cat /var/log/secure | grep -i failed >> /root/failed.txt
cat /var/log/secure | grep -i accepted >> /root/accepted.txt
# EOF
