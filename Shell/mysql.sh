echo -e "\e[32mDisable Mysql Installed version\e[0m"
yum  module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[32m Install Mysql Community Server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[32m Start Mysql Service\e[0m"
systemctl enable mysqld
systemctl restart mysqld

echo -e "\e[32m Setup Mysql Password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

echo -e "\e[32m\e[0m"
mysql -uroot -pRoboShop@1 &>>/tmp/roboshop.log