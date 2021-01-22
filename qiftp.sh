#!/bin/bash

# tw @power_dot 
# Ilya R.

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, use sudo sh $0"
    exit 1
fi



# Script to add a user to Linux system
if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi


# Installing FTP
echo "System update"
apt-get update -y
apt-get upgrade –y
echo "Installing FTP..."
apt-get install vsftpd -y
service vsftpd stop
chmod 777 /etc/vsftpd.conf
cp /etc/vsftpd.conf /etc/vsftpd.conf.default
rm /etc/vsftpd.conf

echo "listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_file=/var/log/vsftpd.log
xferlog_std_format=YES
idle_session_timeout=600
data_connection_timeout=120
chroot_local_user=YES
allow_writeable_chroot=YES
ascii_upload_enable=YES
ascii_download_enable=YES
" > /etc/vsftpd.conf

chmod 644 /etc/vsftpd.conf
echo "" >> /etc/vsftpd.conf

service vsftpd start
exit 0
