#!/bin/bash
# Randy Larson November 22, 2011
# Create some files for backup up
# THIS SCRIPTS IS RUN ON SERVER-A!
mkdir /hr
mkdir -p /root/backups
touch /hr/hr-policies-{1,2,3,4,5,6,7,8,9,10}.txt
touch /hr/hr-policies-{1,2,3,4,5,6,7,8,9,10}.pdf
touch /hr/hr-policies-{1,2,3,4,5,6,7,8,9,10}.wmv
touch /hr/hr-policies-{1,2,3,4,5,6,7,8,9,10}.jpg
touch /hr/hr-policies-{1,2,3,4,5,6,7,8,9,10}.docx
# Just for fun write some zeros to our files
dd if=/dev/zero of=/hr/hr-policies-10.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-10.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-10.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-10.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-10.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-1.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-1.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-1.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-1.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-1.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-2.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-2.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-2.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-2.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-2.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-3.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-3.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-3.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-3.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-3.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-4.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-4.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-4.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-4.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-4.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-5.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-5.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-5.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-5.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-5.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-6.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-6.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-6.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-6.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-6.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-7.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-7.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-7.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-7.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-7.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-8.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-8.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-8.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-8.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-8.wmv bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-9.docx bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-9.jpg bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-9.pdf bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-9.txt bs=512 count=100
dd if=/dev/zero of=/hr/hr-policies-9.wmv bs=512 count=100
# CREATE FAIL-SAFE WARNING MESSAGE FOR E-MAIL!
mkdir -p /root/bin/messages/
echo "You are receiving this message because your "HR" backup directory is failing to mount!" >> /root/bin/messages/warning.txt
echo "Please correct this situation a.s.a.p. and manually run a backup!" >> /root/bin/messages/warning.txt
echo "Your critical "HR" files are NOT being backed up!" >> /root/bin/messages/warning.txt
echo "Your System Administrator" >> /root/bin/messages/warning.txt
# EOF
