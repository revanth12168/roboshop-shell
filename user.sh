source common.sh

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
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cd /app
unzip /tmp/user.zip

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
npm install

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cp /home/centos/roboshop-shell/mongodb.conf /etc/yum.repos.d/mongo.repo

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
mongo --host mongodb-dev.revanthr.online </app/schema/user.js
