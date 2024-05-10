source common.sh
component=frontend

echo -e "${color}Installing Nginx Server${nocolor}"
yum install nginx -y &>>${log_file}
stat_check $?
echo -e "${color}Removing Old App Content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${log_file}
stat_check $?
echo -e "${color}Downloading ${component} Content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
stat_check $?

echo -e "${color}Extract Frontend content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/${component}.zip &>>${log_file}
stat_check $?

#vim /etc/nginx/default.d/roboshop.conf we need to copy config file
echo -e "${color} Update Frontend Configuration${nocolor}"
cp /home/centos/roboshop-shell/Shell/roboshop.conf /etc/nginx/default.d/roboshop.conf
stat_check $?

echo -e "${color}Starting Nginx server${nocolor}"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}
stat_check $?
#



