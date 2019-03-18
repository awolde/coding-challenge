Vagrant.configure("2") do |config|
  config.vm.define "nginx" do |nginx|
    nginx.vm.box = "ubuntu/xenial64"
    nginx.vm.network "private_network", ip: "192.168.10.20"
    nginx.vm.network "forwarded_port", guest: 80, host: 8080
    nginx.vm.provision "chef_zero" do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.nodes_path = "nodes"
      chef.add_recipe "nginx-filebeat"
    end
  end
  config.vm.define "elk" do |elk|
    elk.vm.box = "ubuntu/xenial64"
    elk.vm.provider "virtualbox" do |v|
      v.memory = 6144
      v.cpus = 2
    end
    elk.vm.network "private_network", ip: "192.168.10.10"
    elk.vm.network "forwarded_port", guest: 8080, host: 8090
    elk.vm.provision "chef_zero" do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.nodes_path = "nodes"
      chef.add_recipe "elk-xenial"
    end
  end
end
