script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_name}/common.sh

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install maven -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
useradd ${app_user}

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
unzip /tmp/shipping.zip

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
mvn clean package

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cp ${script_path}/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install mysql -y
mysql -h mysql-dev.revanthr.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping
