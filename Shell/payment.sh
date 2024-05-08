echo -e "\e[32m\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32m\e[0m"
useradd roboshop

echo -e "\e[32m\e[0m"
mkdir /app

echo -e "\e[32m\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[32m\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[32m\e[0m"
cd /app
pip3.6 install -r requirements.txt

echo -e "\e[32m\e[0m"
systemctl daemon-reload

echo -e "\e[32m\e[0m"
systemctl enable payment
systemctl restart payment