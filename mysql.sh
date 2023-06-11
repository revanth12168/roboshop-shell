script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh

 file as a rpm >>>>>\e[0m"
yum module disable mysql -y

 file as a rpm >>>>>\e[0m"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo

 file as a rpm >>>>>\e[0m"
yum install mysql-community-server -y

 file as a rpm >>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld

 file as a rpm >>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1