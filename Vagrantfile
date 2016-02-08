# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    config.vm.define "puppetserver" do |puppetserver|
        puppetserver.vm.provider "vmware_fusion" do |v|
            v.vmx["memsize"] = "3072"
            v.vmx["numvcpus"] = "2"
        end

      puppetserver.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"

      puppetserver.vm.network "private_network", ip: "192.168.33.10"

      puppetserver.vm.hostname = "puppet.grahamgilbert.dev"

      puppetserver.ssh.insert_key = false

    puppetserver.vm.synced_folder "puppetlabs/code", "/etc/puppetlabs/code", type: "rsync", rsync_args:["--verbose", "--archive", "--delete", "-z", "--copy-links", "--chmod=D2775,F777"]
    puppetserver.vm.synced_folder "docker/db", "/usr/local/initial_db", type: "rsync"
    puppetserver.vm.synced_folder "docker/munki", "/usr/local/docker/munki", type: "rsync"

      puppetserver.vm.provision "shell", inline: <<-SHELL
        wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
        sudo dpkg -i puppetlabs-release-pc1-trusty.deb
        sudo rm puppetlabs-release-pc1-trusty.deb
        sudo apt-get update
        #sudo apt-get -y upgrade
        sudo apt-get -y install python-pip
        sudo pip install virtualenv
        sudo touch /var/log/check_csr.out
        sudo chmod 777 /var/log/check_csr.out
        sudo apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet-agent
      SHELL

      puppetserver.vm.provision "puppet" do |puppet|
        puppet.environment = "production"
        puppet.environment_path = "puppetserver_config/environments"
        puppet.binary_path = "/opt/puppetlabs/bin"
      end
  end

  config.vm.define "client1" do |client1|
      # You will need to make your own OS X box.
      # See https://github.com/chilcote/vfuse/wiki/Vagrant
      client1.vm.box = "darwin-1011"
      client1.ssh.insert_key = false
      client1.vm.provider "vmware_fusion" do |v|
            v.gui = true
            v.vmx["memsize"] = "4096"
            v.vmx["numvcpus"] = "2"
            v.vmx["SMBIOS.use12CharSerialNumber"] = "TRUE"
            v.vmx["serialNumber"] = "VMVJT4IK9FV1"
      end
      client1.vm.network "private_network"
      client1.vm.hostname = "client1.grahamgilbert.dev"
      client1.vm.provision "shell", inline: <<-SHELL
        sudo scutil --set HostName client1.grahamgilbert.dev
        sudo scutil --set ComputerName client1.grahamgilbert.dev
        sudo scutil --set LocalHostName client1
      SHELL

      client1.vm.provision "puppet" do |puppet|
        puppet.environment = "production"
        puppet.environment_path = "puppetserver_config/environments"
        puppet.binary_path = "/opt/puppetlabs/bin"
      end
  end

  config.vm.define "client2" do |client2|
      # You will need to make your own OS X box.
      # See https://github.com/chilcote/vfuse/wiki/Vagrant
      client2.vm.box = "darwin-1011"
      client2.ssh.insert_key = false
      client2.vm.provider "vmware_fusion" do |v|
            v.gui = true
            v.vmx["memsize"] = "4096"
            v.vmx["numvcpus"] = "2"
            v.vmx["SMBIOS.use12CharSerialNumber"] = "TRUE"
            v.vmx["serialNumber"] = "VMVJT4IK9FV2"
      end
      client2.vm.network "private_network"
      client2.vm.hostname = "client2.grahamgilbert.dev"
      client2.vm.provision "shell", inline: <<-SHELL
        sudo scutil --set HostName client2.grahamgilbert.dev
        sudo scutil --set ComputerName client2.grahamgilbert.dev
        sudo scutil --set LocalHostName client2
      SHELL

      client2.vm.provision "puppet" do |puppet|
          puppet.environment = "production"
          puppet.environment_path = "puppetserver_config/environments"
          puppet.binary_path = "/opt/puppetlabs/bin"
      end
  end

  # config.vm.define "client3" do |client3|
  #     # You will need to make your own OS X box.
  #     # See https://github.com/chilcote/vfuse/wiki/Vagrant
  #     client3.vm.box = "darwin-1011"
  #     client3.ssh.insert_key = false
  #     client3.vm.provider "vmware_fusion" do |v|
  #           v.gui = true
  #           v.vmx["memsize"] = "4096"
  #           v.vmx["numvcpus"] = "2"
  #           v.vmx["SMBIOS.use12CharSerialNumber"] = "TRUE"
  #           v.vmx["serialNumber"] = "VMVJT4IK9FV3"
  #     end
  #     client3.vm.network "private_network"
  #     client3.vm.hostname = "client3.grahamgilbert.dev"
  #     client3.vm.provision "shell", inline: <<-SHELL
  #       sudo scutil --set HostName client3.grahamgilbert.dev
  #       sudo scutil --set ComputerName client3.grahamgilbert.dev
  #       sudo scutil --set LocalHostName client3
  #     SHELL
  #
  #     client3.vm.provision "puppet" do |puppet|
  #       puppet.environment = "production"
  #       puppet.environment_path = "environments"
  #       puppet.binary_path = "/opt/puppetlabs/bin"
  #     end
  # end

end
