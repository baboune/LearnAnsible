# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = "bento/centos-7.2"
  #config.vm.box_url =  "https://atlas.hashicorp.com/bento/boxes/centos-7.2/versions/2.2.5/providers/virtualbox.box"
  config.vm.box_url = "http://kds-cm-01.rnd.ki.sw.ericsson.se/elk-repo/vagrant/bento-centos-7.2.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  
  # Nodes managed by ansible
  config.vm.define "node1" do |machine|    
    machine.vm.network "private_network", ip: "192.168.50.21"
    machine.vm.hostname = "node-1"
    machine.vm.provider "virtualbox" do |vb|  
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end
  end
  config.vm.define "node2" do |machine|
    machine.vm.network "private_network", ip: "192.168.50.22"
    machine.vm.hostname = "node-2"
    machine.vm.provider "virtualbox" do |vb|  
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end
  end

  config.vm.define "controller" do |machine|
    machine.vm.network "private_network", ip: "192.168.50.10"
    machine.vm.hostname = "controller"
    # Virtualbox options
    machine.vm.provider "virtualbox" do |vb|  
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end
  
    # Setup ansible
    machine.vm.provision "shell", path: 'sh/setup-ansible.sh'  
    machine.vm.provision "shell", path: 'sh/config-ansible.sh'  

    # Patch for https://github.com/mitchellh/vagrant/issues/6793
    config.vm.provision "shell" do |s|
      s.inline = '[[ ! -f $1 ]] || grep -F -q "$2" $1 || sed -i "/__main__/a \\    $2" $1'
      s.args = ['/usr/bin/ansible-galaxy', "if sys.argv == ['/usr/bin/ansible-galaxy', '--help']: sys.argv.insert(1, 'info')"]
    end 
    
    # Run Ansible from the Vagrant VM
    # Must wait for Vagrant 1.8.2, see https://github.com/geerlingguy/drupal-vm/issues/372
    # https://github.com/mitchellh/vagrant/issues/6793
    machine.vm.provision "ansible_local" do |ansible|
      ansible.playbook        = "playbook/playbook.yml"
      ansible.verbose         = true
      ansible.install         = false
      ansible.limit           = "all" # or only "nodes" group, etc
      ansible.inventory_path  = "inventory"
    end
  end
  
end
