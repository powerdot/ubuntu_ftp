#!/bin/bash
echo "System update"
apt-get update -y
apt-get upgrade –y
echo "Installing FTP..."
apt-get install vsftpd -y
service vsftpd stop
chmod 777 /etc/vsftpd.conf
rm /etc/vsftpd.conf
echo "listen=YES" > /etc/vsftpd.conf
echo "listen_ipv6=NO" >> /etc/vsftpd.conf
echo "anonymous_enable=NO" >> /etc/vsftpd.conf
echo "local_enable=YES" >> /etc/vsftpd.conf
echo "write_enable=YES" >> /etc/vsftpd.conf
echo "local_umask=022" >> /etc/vsftpd.conf
echo "use_localtime=YES" >> /etc/vsftpd.conf
echo "xferlog_enable=YES" >> /etc/vsftpd.conf
echo "connect_from_port_20=YES" >> /etc/vsftpd.conf
echo "xferlog_file=/var/log/vsftpd.log" >> /etc/vsftpd.conf
echo "xferlog_std_format=YES" >> /etc/vsftpd.conf
echo "idle_session_timeout=600" >> /etc/vsftpd.conf
echo "data_connection_timeout=120" >> /etc/vsftpd.conf
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
echo "ascii_upload_enable=YES" >> /etc/vsftpd.conf
echo "ascii_download_enable=YES" >> /etc/vsftpd.conf
chmod 644 /etc/vsftpd.conf
service vsftpd start
exit 0
