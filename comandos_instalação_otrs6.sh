#!/bin/bash
yum update -y
yum -y install mariadb-server
systemctl enable mariadb
systemctl stop mariadb
echo  "[mysqld]
max_allowed_packet = 100M
query_cache_size = 32M
innodb_log_file_size = 256M
character-set-server = utf8" > /etc/my.cnf.d/otrs.cnf
rm -rf /var/lib/mysql/ib*
systemctl restart mariadb
setenforce 0
sed -i 's/enforcing/permissive/g' /etc/selinux/config

yum -y install perl-core wget httpd mod_perl mod_ssl openssl
systemctl enable httpd
systemctl start httpd

cd /opt/ 
mkdir otrs 
wget https://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-6.0.27-02.noarch.rpm
yum install otrs-6.0.26-01.noarch.rpm -y
