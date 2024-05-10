#vim /etc/yum.repos.d/mongo.repo
source=common.sh

echo -e "${color}Copy mogo DB Repo file${nocolor}"
cp /home/roboshop-shell/Shell/mongdb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
stat_check

echo -e "${color}Installing MogoDB Server${nocolor}"
yum install mongodb-org -y &>>${log_file}
stat_check

echo -e "${color}Replacing listen address${nocolor}"

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check

echo -e "${color}Installing MogoDB Server${nocolor}"
systemctl enable mongod &>>${log_file}
systemctl restart mongod &>>${log_file}
stat_check
#vim /etc/mongod.conf (Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf)


