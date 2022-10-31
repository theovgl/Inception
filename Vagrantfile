Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.provision :shell, path: "vagrant_provision.sh"
  config.vm.synced_folder ".", "/Inception", create: true
end
