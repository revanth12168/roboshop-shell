script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

 file as a rpm >>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

 file as a rpm >>>>>\e[0m"
yum install rabbitmq-server -y

 file as a rpm >>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

 file as a rpm >>>>>\e[0m"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"