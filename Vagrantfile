# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :'bastion' => {
    :host_name => 'bastion',
    :box_name => "centos/8",
    :public => {ip: '192.168.88.100', adapter:3, bridge:'enp0s31f6'},
    :net => [
      {ip: '192.168.0.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},           
    ],
    :ports => [
      {guest: 22, host: 22001, id: 'ssh'}, 
    ], 
  },
  :'log-1' => {
    :host_name => 'log-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.6', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},           
    ],
    :ports => [
      {guest: 22, host: 22006, id: 'ssh'}, 
      {guest: 9200, host: 9200}, 
      {guest: 9300, host: 9300},
      {guest: 5601, host: 5601},
    ],
    :memory => 4096,
    :cpus => 2,
  },
  :'monitoring-1' => {
    :host_name => 'monitoring-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.5', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},           
    ],
    :ports => [
      {guest: 22, host: 22005, id: 'ssh'}, 
      {guest: 9090, host: 9090}, 
      {guest: 3000, host: 3000},
    ],
    :memory => 4096,
    :cpus => 2,
  },
  :'db-1' => {
    :host_name => 'db-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.4', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},
    ],
    :ports => [
      {guest: 22, host: 22004, id: 'ssh'}, 
    ]
  },
  :'backend-1'=> {
    :host_name => 'backend-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.3', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},
    ],
    :ports => [
      {guest: 22, host: 22003, id: 'ssh'}, 
    ]
  },
  :'web-1' => {
    :host_name => 'web-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.2', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},
    
    ],
    :ports => [
      {guest: 22, host: 22002, id: 'ssh'}, 

    ],
  },
  :'backup-1' => {
    :host_name => 'backup-1',
    :box_name => "centos/8",
    :net => [
      {ip: '192.168.0.7', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "internal-net"},
    ],
    :ports => [
      {guest: 22, host: 22007, id: 'ssh'}, 
    ]
  },
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|
      box.vm.synced_folder ".", "/vagrant", type: "rsync", disabled: true
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxname.to_s

      if boxconfig.key?(:public)
         box.vm.network "public_network", boxconfig[:public]
      end

      boxconfig[:net].each do |ipconf|
        box.vm.network "private_network", ipconf
      end
      if boxconfig[:ports]
        boxconfig[:ports].each do |portconf|
          box.vm.network "forwarded_port", portconf
        end
      end 
      if boxconfig[:memory]
        box.vm.provider "virtualbox" do |v|
          v.memory = boxconfig[:memory]
       #   v.cpus = box[:cpus]
        end
      end 
     # box.vm.provision "ansible" do |ansible|
     #   ansible.playbook = "provisioning/main.yml"
      #end
    end
  end
end

