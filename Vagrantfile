# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "2048"
    vb.name = "docker4all"
  end

  config.vm.network "forwarded_port", guest: 9090, host: 9090
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 50000, host: 50000
  config.vm.network "private_network", ip: "192.168.50.10"

  config.vm.provision :shell, path: "install_docker.sh"

end
