app_user=roboshop

script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

func_print_head() {
  echo -e "\e[36m <<<<< $1 >>>>>\e[0m"
}


schema_setup() {
  if [ "${schema_setup}" == mongo]; then

    func_print_head "copy Mongo DB"
    cp ${script_path}/mongodb.conf /etc/yum.repos.d/mongo.repo

    func_print_head "Install mongodb client"
    yum install mongodb-org-shell -y
    mongo --host mongodb-dev.revanthr.online </app/schema/${component}.js

  fi
  if [ "${schema_setup}" == mysql]; then

    func_print_head "to load schema we need to install mysql client"
    yum install mysql -y
    mysql -h mysql-dev.revanthr.online -uroot -p${mysql_appuser_password} < /app/schema/${component}.sql
  fi


}



func_prereq() {

    func_print_head "create the user"
    useradd ${app_user}

    func_print_head "setup an app directory"
    rm -rf /app
    mkdir /app

    func_print_head "Download the application code to created app directory"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app

    func_print_head "unzip the code"
    unzip /tmp/${component}.zip
}





func_systemd_setup() {
    func_print_head "Setup SystemD ${component} Service"
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

    func_print_head "Restart the service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}

func_status_check() {
  if [ $1 -ne 0]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[om"
    exit 1
  fi
}



fnc_nodejs() {

  func_print_head "Repo file as a rpm"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  func_print_head "Repo file as a rpm"
  yum install nodejs -y

  func_print_head "Repo file as a rpm"
  useradd ${app_user}

  func_print_head "Repo file as a rpm"
  rm -rf /app
  mkdir /app

  func_print_head "Repo file as a rpm"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  func_print_head "Repo file as a rpm"
  cd /app
  unzip /tmp/${component}.zip

  func_print_head "Repo file as a rpm"
  npm install

  func_systemd_setup

  schema_setup

}







func_java() {

  func_print_head "Configure the application"
  yum install maven -y

  func_prereq

  func_print_head "download the dependencies"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar

  schema_setup
  func_systemd_setup

}