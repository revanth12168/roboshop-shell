script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=catalogue

fnc_nodejs

echo -e "\e[36m <<<<<<copy Mongo DB>>>>>>\e[0m"
cp ${script_path}/mongodb.conf /etc/yum.repos.d/mongo.repo

echo -e "\e[36m <<<<<< Install mongodb client >>>>>>\e[0m"
yum install mongodb-org-shell -y
mongo --host mongodb-dev.revanthr.online </app/schema/catalogue.js