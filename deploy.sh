#!/bin/sh
 
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
