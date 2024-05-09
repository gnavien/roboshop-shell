source common.sh
component=catalogue

nodejs


echo -e "${color} Copy Mongodb repo file ${noclor}"
cp /home/centos/roboshop-shell/Shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>log_file

echo -e "${color} Install MongoDB client ${noclor}"
yum install mongodb-org-shell -y &>>log_file

echo -e "${color} Load Schema ${noclor}"
mongo --host mongodb-dev.navien.cloud </app/schema/$component.js &>>log_file


