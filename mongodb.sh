#vim /etc/yum.repos.d/mongo.repo
echo -e "\e[32mCopy mogo DB Repo file\e[0m"
cp mongdb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "\e[32mInstalling MogoDB Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[32mReplacing listen address\e[0m"

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[32mInstalling MogoDB Server\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
#vim /etc/mongod.conf (Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf)

