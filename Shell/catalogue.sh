echo -e "\e[32m Configuring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[32m Install Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[32m Add Application User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32m Create Application Directory \e[0m"
rm-rf /app
mkdir /app

echo -e "\e[32m Download Application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[32m Extract application content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[32m Install Nodejs dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log

echo -e "\e[32m Setup systemd services\e[0m"
cp /home/roboshop-shell/Shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32m Start Catalogue service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[32m Copy Mongodb repo file\e[0m"
cp /home/roboshop-shell/Shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[32m Install MongoDB client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[32m Load Schema\e[0m"
mongo --host mongodb-dev.navien.cloud </app/schema/catalogue.js


