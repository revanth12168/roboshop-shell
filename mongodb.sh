script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_name}/common.sh

echo -e "\e[36m <<<<< Setup the MongoDB >>>>>\e[0m"
cp mongodb.conf /etc/yum.repos.d/mongo.repo

echo -e "\e[36m <<<<< Install MongoDB >>>>>\e[0m"
yum install mongodb-org -y

echo -e "\e[36m <<<<< Update listen address from 127.0.0.1 to 0.0.0.0  >>>>>\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m <<<<< Restart the service >>>>>\e[0m"
systemctl enable mongod
systemctl restart mongod
