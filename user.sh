script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=user

fnc_nodejs


 file as a rpm >>>>>\e[0m"
cp ${script_path}/mongodb.conf /etc/yum.repos.d/mongo.repo

 file as a rpm >>>>>\e[0m"
yum install mongodb-org-shell -y

 file as a rpm >>>>>\e[0m"
mongo --host mongodb-dev.revanthr.online </app/schema/user.js
