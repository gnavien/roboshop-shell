source common.sh
component=catalogue


echo -e "${color} Configuring Nodejs repos ${noclor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file

echo -e "${color} Install Nodejs${noclor}"
yum install nodejs -y &>>log_file

echo -e "${color} Add Application User${noclor}"
useradd roboshop &>>log_file

echo -e "${color} Create Application Directory ${noclor}"
rm -rf ${app_path}
mkdir ${app_path}

echo -e "${color} Download Application content ${noclor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>log_file
cd ${app_path}

echo -e "${color} Extract application content${noclor}"
unzip /tmp/$component.zip &>>log_file

echo -e "${color} Install Nodejs dependencies${noclor}"
cd ${app_path}
npm install &>>log_file

echo -e "${color} Setup systemd services${noclor}"
cp /home/centos/roboshop-shell/Shell/$component.service /etc/systemd/system/$component.service

echo -e "${color} Start Catalogue service ${noclor}"
systemctl daemon-reload &>>log_file
systemctl enable $component &>>log_file
systemctl restart $component &>>log_file

echo -e "${color} Copy Mongodb repo file ${noclor}"
cp /home/centos/roboshop-shell/Shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>log_file

echo -e "${color} Install MongoDB client ${noclor}"
yum install mongodb-org-shell -y &>>log_file

echo -e "${color} Load Schema ${noclor}"
mongo --host mongodb-dev.navien.cloud </app/schema/$component.js &>>log_file


