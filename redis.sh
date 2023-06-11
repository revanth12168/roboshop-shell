script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m <<<<< Repo file as a rpm >>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m <<<<< enable redis >>>>\e[0m"
yum module enable redis:remi-6.2 -y

echo -e "\e[36m <<<<< Install redis >>>>>\e[0m"
yum install redis -y

echo -e "\e[36m <<<<< Replace the listen address >>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis/redis.conf /etc/redis.conf

echo -e "\e[36m <<<<< restart the service >>>>>\e[0m"
systemctl enable redis
systemctl restart redis