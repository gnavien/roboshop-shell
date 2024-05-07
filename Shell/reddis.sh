yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

##Enable Redis 6.2 from package streams
yum module enable redis:remi-6.2 -y

Install Redis
dnf install redis -y


systemctl enable redis
systemctl restart redis