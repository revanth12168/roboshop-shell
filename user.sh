curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
rm -rf /app
mkdir /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
npm install
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl restart user

cp /home/centos/roboshop-shell/mongodb.conf /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

mongo --host mongodb-dev.revanthr.online </app/schema/user.js
