app_user=roboshop

script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head() {
  echo -e "\e[36m <<<<< $1 >>>>>\e[0m"
}




schema_setup() {
  if [ "${schema_setup}" == mongo]; then
    print_head "copy Mongo DB"
    cp ${script_path}/mongodb.conf /etc/yum.repos.d/mongo.repo

    print_head "Install mongodb client"
    yum install mongodb-org-shell -y
    mongo --host mongodb-dev.revanthr.online </app/schema/${component}.js
  fi
  if [ "${schema_setup}" == mysql]; then

    print_head "to load schema we need to install mysql client"
    yum install mysql -y
    mysql -h mysql-dev.revanthr.online -uroot -p${mysql_appuser_password} < /app/schema/${component}.sql
  fi


}



func_prereq() {

    print_head "create the user"
    useradd ${app_user}

    print_head "setup an app directory"
    rm -rf /app
    mkdir /app

    print_head "Download the application code to created app directory"
    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app

    print_head "unzip the code"
    unzip /tmp/${component}.zip
}





func_systemd_setup() {
    print_head "Setup SystemD ${component} Service"
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

    print_head "Restart the service"
    systemctl daemon-reload
    systemctl enable ${component}
    systemctl restart ${component}
}






fnc_nodejs() {

  print_head "Repo file as a rpm"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print_head "Repo file as a rpm"
  yum install nodejs -y

  print_head "Repo file as a rpm"
  useradd ${app_user}

  print_head "Repo file as a rpm"
  rm -rf /app
  mkdir /app

  print_head "Repo file as a rpm"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  print_head "Repo file as a rpm"
  cd /app
  unzip /tmp/${component}.zip

  print_head "Repo file as a rpm"
  npm install

  func_systemd_setup

  schema_setup

}







func_java() {

  print_head "Configure the application"
  yum install maven -y

  func_prereq

  print_head "download the dependencies"
  mvn clean package
  mv target/${component}-1.0.jar ${component}.jar

  schema_setup
  func_systemd_setup

}