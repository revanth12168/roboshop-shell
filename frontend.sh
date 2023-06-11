script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

echo -e "\e[36m <<<<< Installing nginx >>>>>\e[0m"
yum install nginx -y

echo -e "\e[36m <<<<< creating and updating configuration file >>>>>\e[0m"
cp ${script_path}/roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m <<<<< Remove the default content that web server >>>>>\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m <<<<< Download the frontend content >>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m <<<<< Extract the frontend content >>>>>\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m <<<<< Restart Nginx Service >>>>>\e[0m"
systemctl restart nginx
systemctl enable nginx
