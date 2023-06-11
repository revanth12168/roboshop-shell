script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

echo -e "\e[36m <<<<< Installing Python >>>>>\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m <<<<< Creating user >>>>>\e[0m"
useradd ${app_user}

echo -e "\e[36m <<<<< downloading source >>>>>\e[0m"
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo -e "\e[36m <<<<< unziping >>>>>\e[0m"
cd /app
unzip /tmp/payment.zip

echo -e "\e[36m <<<<< install >>>>>\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m <<<<< Creating service >>>>>\e[0m"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}" ${script_path}/payment.service
cp ${script_path}/payment.service /etc/systemd/system/payment.service


echo -e "\e[36m <<<<< restart the service >>>>>\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
