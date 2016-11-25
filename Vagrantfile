# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  config.vm.provider "virtualbox" do |vb|
     vb.name = "git-jenkins-pof"
     vb.memory = "2048"
     vb.cpus = 2
  end

  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
#    apt-get install apt-transport-https ca-certificates
#    sudo apt-key adv \
#               --keyserver hkp://ha.pool.sks-keyservers.net:80 \
#               --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
#    apt-get update
    apt-get install docker-engine git -y
    echo "DOCKER_OPTS='-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock'" | sudo tee /etc/default/docker
    service docker start
    git clone https://github.com/iambryancs/git-jenkins-pof.git /home/vagrant/git-jenkins-pof
    cd /home/vagrant/git-jenkins-pof
    docker-compose up
  SHELL
end
