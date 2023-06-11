script=$(realpath $0)
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m <<<<< installing golang>>>>>\e[0m"
yum install golang -y

echo -e "\e[36m <<<<<<< adding user >>>>>>>\e[om"
useradd ${app_user}

echo -e "\e[36m <<<<<<< creating the directory >>>>>>>\e[om"
mkdir /app

echo -e "\e[36m <<<<<<< downloading the source >>>>>>>\e[om"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

echo -e "\e[36m <<<<<<< unzip the source >>>>>>>\e[om"
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[36m <<<<<<< Downloading the dependencies >>>>>>>\e[om"
go mod init dispatch
go get
go build

echo -e "\e[36m <<<<<<< Creating the service and updating the file >>>>>>>\e[om"
cp ${script_path}/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m <<<<<<< Starting the service >>>>>>>\e[om"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch