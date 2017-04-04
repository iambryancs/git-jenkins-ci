# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box config
  config.vm.box = "ubuntu/trusty64"

  # Forwarded ports
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # VirtualBox config
  config.vm.provider "virtualbox" do |vb|
     vb.name = "git-jenkins-ci-cd"
     vb.memory = "2048"
     vb.cpus = 2
  end

  # Shell provisioning - add deploy key to authorized_keys of vm
  config.vm.provision "shell", inline: <<-SHELL
    cat /vagrant/keys/deploy_key.pub >> /home/vagrant/.ssh/authorized_keys
  SHELL

  # Docker provisioning - run Jenkins
  config.vm.provision "docker" do |d|
    d.run "jenkinsci/jenkins",
      args: "--name jenkins -p '8000:8000' -p '5000:5000' --network=host"
  end
end
