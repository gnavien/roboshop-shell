source common.sh

echo -e "${color} Install Redis Repos${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}
stat_check

##Enable Redis 6.2 from package streams

echo -e "${color} Enable Redis 6 Version${nocolor}"
yum module enable redis:remi-6.2 -y &>>${log_file}
stat_check

echo -e "${color} Install Redis${nocolor}"
yum install redis -y &>>${log_file}
stat_check

echo -e "${color} Update Listen address${nocolor}"
sed -i '/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
stat_check

echo -e "${color} Start Redis Service${nocolor}"
systemctl enable redis &>>${log_file}
systemctl restart redis &>>${log_file}
stat_check