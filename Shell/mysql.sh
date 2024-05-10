source common.sh

echo -e "${color}mDisable Mysql Installed version${nocolor}"
yum  module disable mysql -y &>>${log_file}
stat_check

echo -e "${color}m Copy MySql repo file ${nocolor}"
cp  /home/centos/roboshop-shell/Shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
stat_check

echo -e "${color}m Install Mysql Community Server${nocolor}"
yum install mysql-community-server -y &>>${log_file}
stat_check

echo -e "${color}m Start Mysql Service${nocolor}"
systemctl enable mysqld
systemctl restart mysqld
stat_check

echo -e "${color}m Setup Mysql Password${nocolor}"
mysql_secure_installation --set-root-pass RoboShop@1 &>>${log_file}
stat_check
#echo -e "${color}m${nocolor}"
#mysql -uroot -pRoboShop@1 &>>${log_file}
# netstat -lntp to check the database port is working