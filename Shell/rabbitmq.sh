echo -e "\e[32m\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[32m\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[32m Installing RabbitMq on to the Server\e[0m"
yum install rabbitmq-server -y

echo -e "\e[32m Adding user for RabbitMq \e[0m"
rabbitmqctl add_user roboshop roboshop123

echo -e "\e[32m Setting of permission to user roboshop\e[0m"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

echo -e "\e[32m Restart of service\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server