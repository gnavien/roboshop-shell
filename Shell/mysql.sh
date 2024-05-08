echo -e "\e[32m\e[0m"
yum  module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[32m\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

systemctl enable mysqld
systemctl start mysqld

mysql_secure_installation --set-root-pass RoboShop@1

mysql -uroot -pRoboShop@1