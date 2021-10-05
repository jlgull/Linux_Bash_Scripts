#!/bin/bash
groupadd -g 10001 student1
groupadd -g 10002 student2
groupadd -g 10003 student3
groupadd -g 10004 student4
groupadd -g 10005 student5
groupadd -g 10006 student6
groupadd -g 10007 student7
groupadd -g 10008 student8
groupadd -g 10009 student9
groupadd -g 10010 student10
groupadd -g 10011 student11
groupadd -g 10012 student12
groupadd -g 10013 student13
groupadd -g 10014 student14
groupadd -g 10015 student15
groupadd -g 10016 student16
groupadd -g 10017 student17
groupadd -g 10018 student18
groupadd -g 10019 student19
groupadd -g 10020 student20
groupadd -g 10061 student61
groupadd -g 10062 student62
groupadd -g 10063 student63
groupadd -g 10064 student64
groupadd -g 10220 instructor
# END OF GROUPS
useradd student1 -c "Student One" -u 10001 -g 10001
useradd student2 -c "Student Two" -u 10002 -g 10002
useradd student3 -c "Student Three" -u 10003 -g 10003
useradd student4 -c "Student Four" -u 10004 -g 10004
useradd student5 -c "Student Five" -u 10005 -g 10005
useradd student6 -c "Student Six" -u 10006 -g 10006
useradd student7 -c "Student Seven" -u 10007 -g 10007
useradd student8 -c "Student Eight" -u 10008 -g 10008
useradd student9 -c "Student Nine" -u 10009 -g 10009
useradd student10 -c "Student Ten" -u 10010 -g 10010
useradd student11 -c "Student Eleven" -u 10011 -g 10011
useradd student12 -c "Student Twelve" -u 10012 -g 10012
useradd student13 -c "Student Thirteen" -u 10013 -g 10013
useradd student14 -c "Student Fourteen" -u 10014 -g 10014
useradd student15 -c "Student Fifteen" -u 10015 -g 10015
useradd student16 -c "Student Sixteen" -u 10016 -g 10016
useradd student17 -c "Student Seventeen" -u 10017 -g 10017
useradd student18 -c "Student Eighteen" -u 10018 -g 10018
useradd student19 -c "Student Nineteen" -u 10019 -g 10019
useradd student20 -c "Student Twenty" -u 10020 -g 10020
useradd student61 -c "Student Sixty-one" -u 10061 -g 10061
useradd student62 -c "Student Sixty-two" -u 10062 -g 10062
useradd student63 -c "Student Sixty-three" -u 10063 -g 10063
useradd student64 -c "Student Sixty-four" -u 10064 -g 10064
useradd instructor -c "Instructor" -u 10220 -g 10220
# END OF USERS
echo "password" >> /root/password.txt
passwd --stdin student1 < /root/password.txt
passwd --stdin student2 < /root/password.txt
passwd --stdin student3 < /root/password.txt
passwd --stdin student4 < /root/password.txt
passwd --stdin student5 < /root/password.txt
passwd --stdin student6 < /root/password.txt
passwd --stdin student7 < /root/password.txt
passwd --stdin student8 < /root/password.txt
passwd --stdin student9 < /root/password.txt
passwd --stdin student10 < /root/password.txt
passwd --stdin student11 < /root/password.txt
passwd --stdin student12 < /root/password.txt
passwd --stdin student13 < /root/password.txt
passwd --stdin student14 < /root/password.txt
passwd --stdin student15 < /root/password.txt
passwd --stdin student16 < /root/password.txt
passwd --stdin student17 < /root/password.txt
passwd --stdin student18 < /root/password.txt
passwd --stdin student19 < /root/password.txt
passwd --stdin student20 < /root/password.txt
passwd --stdin student61 < /root/password.txt
passwd --stdin student62 < /root/password.txt
passwd --stdin student63 < /root/password.txt
passwd --stdin student64 < /root/password.txt
passwd --stdin instructor < /root/password.txt
# Enforce Password Expiration on student1 only!
chage -d 0 student1
# Make new directories or check to see if they are there!
dir=/assignments/honors
if [[ ! -e $dir ]]; then
    mkdir -p $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
# Make new private group
groupadd students
usermod -a -G students student1
usermod -a -G students student2
usermod -a -G students student3
usermod -a -G students student4
usermod -a -G students student5
usermod -a -G students student6
usermod -a -G students student7
usermod -a -G students student8
usermod -a -G students student9
usermod -a -G students student10
usermod -a -G students student11
usermod -a -G students student12
usermod -a -G students student13
usermod -a -G students student14
usermod -a -G students student15
usermod -a -G students student16
usermod -a -G students student17
usermod -a -G students student18
usermod -a -G students student19
usermod -a -G students student20
usermod -a -G students student61
usermod -a -G students student62
usermod -a -G students student63
usermod -a -G students student64
groupadd honor-students
usermod -a -G honor-students student1
usermod -a -G honor-students student2
usermod -a -G honor-students student3
chown instructor:students /assignments
chown instructor:honor-students /assignments/honors
chmod 2770 /assignments
chmod 3770 /assignments/honors
cd /assignments/
touch student1-{1,2,3,4,5,6,7,8,9,10}.txt
chown student1:students student1*.txt
chmod 660 student1*.txt
cd /assignments/honors
touch student1-{1,2,3,4,5,6,7,8,9,10}.txt
chown student1:honor-students student1*.txt
chmod 660 student1*.txt
cd /assignments/
touch student4-{1,2,3,4,5,6,7,8,9,10}.mp4
chown student4:students student4*.mp4
chmod 660 student4*.mp4
cd /assignments/honors/
touch student1-{1,2,3,4,5,6,7,8,9,10}.doc
touch student1-{1,2,3,4,5,6,7,8,9,10}.xls
chown student1:honor-students student1*.doc
chmod 660 student1*.doc
chown student1:honor-students student1*.xls
chmod 660 student1*.xls
#EOF
