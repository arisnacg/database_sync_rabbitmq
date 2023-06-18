Vagrant.configure("2") do |config|
  config.vm.define "ubuntu1" do |ubuntu1|
    ubuntu1.vm.box = "bento/ubuntu-22.04"
    ubuntu1.vm.network "private_network", ip: "192.168.56.2",
      name: "VirtualBox Host-Only Ethernet Adapter"
    ubuntu1.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "ubuntu2" do |ubuntu2|
    ubuntu2.vm.box = "bento/ubuntu-22.04"
    ubuntu2.vm.network "private_network", ip: "192.168.56.3",
      name: "VirtualBox Host-Only Ethernet Adapter"
    ubuntu2.vm.synced_folder '.', '/vagrant', disabled: true
  end
end
