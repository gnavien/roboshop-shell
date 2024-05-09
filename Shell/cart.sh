source common.sh
component=cart

echo -e "${color}Configuring Nodejs repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color}Install Nodejs${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color}Add Application User ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color}Create Application Directory ${nocolor}"
rm -rf ${app_path}
mkdir ${app_path}

echo -e "${color}Download Application content ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path}

echo -e "${color}Extract application content${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color}Install Nodejs dependencies${nocolor}"
cd ${app_path}
npm install &>>${log_file}

echo -e "${color}Setup systemd services${nocolor}"
cp /home/centos/roboshop-shell/Shell/${component}.service /etc/systemd/system/${component}.service

echo -e "${color}Start cart service ${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}

