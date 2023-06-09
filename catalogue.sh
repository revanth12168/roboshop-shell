echo -e "\e[36m<<<<configure npm >>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m <<<<<<install>>>>>>\e[0m"
yum install nodejs -y

echo -e "\e[36m <<<<<<Add user>>>>>>\e[0m"
useradd roboshop

echo -e "\e[36m <<<<<<create directory>>>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m <<<<<<source>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[36m <<<<<<source>>>>>>\e[0m"
unzip /tmp/catalogue.zip
echo -e "\e[36m <<<<<<dependencies>>>>>>\e[0m"
npm install

echo -e "\e[36m <<<<<<Create config files>>>>>>\e[0m"
cp /home/centos/roboshop-shell/catalogue.conf /etc/systemd/system/catalogue.service

echo -e "\e[36m <<<<<<start service>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[36m <<<<<<copy Mongo DB>>>>>>\e[0m"
cp /home/centos/roboshop-shell/mongodb.conf /etc/yum.repos.d/mongo.repo

echo -e "\e[36m <<<<<< Install mongodb client >>>>>>\e[0m"
yum install mongodb-org-shell -y
mongo --host mongodb-dev.revanthr.online </app/schema/catalogue.js