app_user=roboshop

print head() {
  echo -e "\e[36m <<<<< $1 >>>>>\e[0m"
}

schema setup() {

  print head copy Mongo DB
  cp ${script_path}/mongodb.conf /etc/yum.repos.d/mongo.repo

  print head Install mongodb client
  yum install mongodb-org-shell -y
  mongo --host mongodb-dev.revanthr.online </app/schema/catalogue.js

}

fnc_nodejs() {

  print head "Repo file as a rpm"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  print head "Repo file as a rpm"
  yum install nodejs -y

  print head "Repo file as a rpm"
  useradd ${app_user}

  print head "Repo file as a rpm"
  rm -rf /app
  mkdir /app

  print head "Repo file as a rpm"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip

  print head "Repo file as a rpm"
  cd /app
  unzip /tmp/${component}.zip

  print head "Repo file as a rpm"
  npm install

  print head "checking"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

  print head "Repo file as a rpm"
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl restart ${component}
  schema setup
}

