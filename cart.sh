script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_name}/common.sh

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install nodejs -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
useradd ${app_user}

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cd /app
unzip /tmp/cart.zip

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
npm install

echo -e "\e[32m <<<<<<checking>>>>>\e[0m"
cp ${script_path}/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart