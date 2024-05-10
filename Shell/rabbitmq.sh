source=common.sh

echo -e "${color} Configure Erlang Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Configure RabbitMq Repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Installing RabbitMq on to the Server${nocolor}"
yum install rabbitmq-server -y  &>>${log_file}

echo -e "${color} start RabbitMq service${nocolor}"
systemctl enable rabbitmq-server &>>${log_file}
systemctl restart rabbitmq-server &>>${log_file}

echo -e "${color} Setting of permission to user roboshop${nocolor}"
rabbitmqctl add_user roboshop roboshop123  &>>${log_file}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"  &>>${log_file}

