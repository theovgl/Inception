Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.provision :shell, path: "vagrant_provision.sh"
  config.vm.synced_folder ".", "/Inception", create: true
  config.vm.network "forwarded_port", guest: 3128, host: 3128
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end
  #config.ssh.username = 'tvogel'
end

