color="\e32m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup() {

   echo -e "${color} Add Application User${noclor}"
   useradd roboshop &>>${log_file}

   echo -e "${color} Creating application  Directory App${nocolor}"
   mkdir ${app_path}  &>>${log_file}

   echo -e "${color} Download Application content ${noclor}"
   curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>{log_file}


   echo -e "${color} Extract application content${noclor}"
   cd ${app_path}
   unzip /tmp/$component.zip &>>log_file
}

systemd_setup() {

  echo -e "${color} Start $component service ${noclor}"
  systemctl daemon-reload &>>${log_file}
  systemctl enable $component &>>${log_file}
  systemctl restart $component &>>${log_file}

}
nodejs () {
  echo -e "${color} Configuring Nodejs repos ${noclor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_file

  app_presetup

  echo -e "${color} Install Nodejs${noclor}"
  yum install nodejs -y &>>log_file


  systemd_setup


  echo -e "${color} Install Nodejs dependencies${noclor}"
  cd ${app_path}
  npm install &>>log_file

  echo -e "${color} Setup systemd services${noclor}"
  cp /home/centos/roboshop-shell/Shell/$component.service /etc/systemd/system/$component.service


}

mongodb_schema_setup() {
  echo -e "${color} Copy Mongodb repo file${nocolor}"
  cp /home/centos/roboshop-shell/Shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}

  echo -e "${color} Install MongoDB client${nocolor}"
  yum install mongodb-org-shell -y &>>{log_file}

  echo -e "${color} Load Schema${nocolor}"
  mongo --host mongodb-dev.navien.cloud </app/schema/$component.js
}

mysql_schema_setup() {
  echo -e "${color} Install MySql${nocolor}"
  yum install mysql -y  &>>${log_file}

  echo -e "${color} Load Schema${nocolor}"
  mysql -h mysql-dev.navien.cloud -uroot -pRoboShop@1 < /app/schema/$component.sql  &>>${log_file}
}

maven() {

  echo -e "${color} Install Maven${nocolor}"
  yum install maven -y &>>${log_file}

  app_presetup
  echo -e "${color} Download Maven Dependencies${nocolor}"
  mvn clean package &>>${log_file}
  mv target/$component-1.0.jar $component.jar &>>${log_file}
  mysql_schema_setup
  systemd_setup
}

python() {
  echo -e "${color} Install Pyton Dependencies ${nocolor}"
  yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

  app_presetup

  echo -e "${color} Install Application Dependencies${nocolor}"
  cd /app &>>/tmp/roboshop.log
  pip3.6 install -r requirements.txt  &>>/tmp/roboshop.log

  systemd_setup

}