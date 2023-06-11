echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum module disable mysql -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1