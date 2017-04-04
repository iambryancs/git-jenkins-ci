#!/bin/sh

mkdir /var/jenkins_home/.ssh || true

ssh-keyscan 172.17.0.1 >> /var/jenkins_home/.ssh/known_hosts
cp ./keys/deploy_key /var/jenkins_home/.ssh/id_rsa
chmod 600 /var/jenkins_home/.ssh/id_rsa
  
ssh vagrant@172.17.0.1 <<EOF
  docker rmi -f bryancs/git-jenkins-ci || true
  docker rm -f git-jenkins-ci-demo-app || true
  rm -rf ~/git-jenkins-ci
  cd ~
  git clone https://github.com/iambryancs/git-jenkins-ci.git
  cd git-jenkins-ci/app
  docker build -t bryancs/git-jenkins-ci .
  docker run -d -p 8000:8000 --name git-jenkins-ci-demo-app bryancs/git-jenkins-ci
  exit
EOF
