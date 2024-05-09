echo -e "\e[32m Configuring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32m Install Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32m Add Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32m Create Application Directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m Download Application content \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32m Extract application content\e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[32m Install Nodejs dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[32m Setup systemd services\e[0m"
cp /home/centos/roboshop-shell/Shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[32m Start cart service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

