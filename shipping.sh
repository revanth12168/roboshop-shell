script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_appuser_password=$1

 file as a rpm >>>>>\e[0m"
yum install maven -y

 file as a rpm >>>>>\e[0m"
useradd ${app_user}

 file as a rpm >>>>>\e[0m"
rm -rf /app
mkdir /app

 file as a rpm >>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

 file as a rpm >>>>>\e[0m"
unzip /tmp/shipping.zip

 file as a rpm >>>>>\e[0m"
mvn clean package

 file as a rpm >>>>>\e[0m"
mv target/shipping-1.0.jar shipping.jar

 file as a rpm >>>>>\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service

 file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

 file as a rpm >>>>>\e[0m"
yum install mysql -y
mysql -h mysql-dev.revanthr.online -uroot -p${mysql_appuser_password} < /app/schema/shipping.sql

 file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
