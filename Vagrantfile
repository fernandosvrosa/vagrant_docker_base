# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker' if /linux/ =~ RUBY_PLATFORM
ENV['SSH_AUTH_SOCK'] = ''

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
config.ssh.insert_key = false
  if /linux/ =~ RUBY_PLATFORM
    config.vm.provider 'docker' do |d|
    d.build_dir = '.'
    d.has_ssh = true
  end

  config.vm.hostname = Socket.gethostname
  else
    config.vm.box = 'ubuntu/xenial64'
    config.vm.box_version = '20170119.1.0'
    config.vm.network :private_network, ip: '192.168.56.10'

    config.vm.provider 'virtualbox' do |vb|
      vb.memory = 4096
      vb.cpus = 3
    end
  end

end
