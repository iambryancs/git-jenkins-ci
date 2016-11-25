#!/bin/sh

mkdir /var/jenkins_home/.ssh

ssh-keyscan 172.17.0.1 >> /var/jenkins_home/.ssh/known_hosts
cp ./keys/deploy_key /var/jenkins_home/.ssh/id_rsa
chmod 600 /var/jenkins_home/.ssh/id_rsa
  
ssh vagrant@172.17.0.1 <<EOF
  docker rmi -f bryancs/gjp || true
  docker rm -f gjp-demo || true
  rm -rf ~/git-jenkins-pof
  cd ~
  git clone https://github.com/iambryancs/git-jenkins-pof.git
  cd git-jenkins-pof/app
  docker build -t bryancs/gjp .
  docker run -d -p 8000:8000 --name gjp-demo bryancs/gjp
  exit
EOF
