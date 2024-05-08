echo -e "\e[32mInstalling Nginx Server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log

echo -e "\e[32mRemoving Old App Content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\e[32mDownloading frontend Content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log

echo -e "\e[32mExtract Frontend content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

#vim /etc/nginx/default.d/roboshop.conf we need to copy config file
echo -e "\e[32m Update Frontend Configuration\e[0m"
cp /home/roboshop-shell/Shell/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32mStarting Nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
#



