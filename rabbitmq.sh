script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_name}/common.sh
rabbitmq_appuser_password=$1

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install rabbitmq-server -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"