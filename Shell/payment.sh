echo -e "\e[32m Install Pyton Dependencies \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[32m Adding application  User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[32m Create Directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[32m Download application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[32m Extract application content\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[32m Install Application Dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
pip3.6 install -r requirements.txt  &>>/tmp/roboshop.log

echo -e "\e[32m Setup systemd services\e[0m"
cp /home/centos/roboshop-shell/Shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[32mStart Payment  service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment  &>>/tmp/roboshop.log
systemctl restart payment  &>>/tmp/roboshop.log