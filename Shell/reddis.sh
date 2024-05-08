echo -e "\e[32m\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

##Enable Redis 6.2 from package streams

echo -e "\e[32m\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[32m\e[0m"
Install Redis &>>/tmp/roboshop.log
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[32m\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log