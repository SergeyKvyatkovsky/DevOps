#(1..2).each do |i|

# GLOBAL VARIABLES
os_srv = 'centos/7'
server1_hostname = 'host1'
server1_domain = 'local'
server2_hostname = 'host2'
server2_domain = 'local'
server1_private_ip = '192.168.1.5'
server2_private_ip = '192.168.1.6'

	Vagrant.configure("2") do |config|

		#GLOBAL SETTINGS 

		config.vm.box = os_srv
		config.vm.provision "shell", inline: <<-SHELL

			#SET GLOBAL DNS (crutch)

			echo 192.168.1.5 host1.local.home.lan dnsserverer >> /etc/hosts
			echo 192.168.1.6 host2.local.home.lan >> /etc/hosts

			SHELL

			# START server1 SETTINGS SECTION

		config.vm.define "server1" do |server1|
			server1.vm.hostname = server1_hostname +'.'+ server1_domain

			server1.vm.network "private_network", ip: server1_private_ip
			server1.vm.network "public_network"
			server1.vm.provider "virtualbox" do |server1|
				server1.gui = true

			end

		# START server1 PROVISION SECTION

			server1.vm.provision "shell", inline: <<-SHELL
				yum install -y mc
				cd ..		
			SHELL

		end
	
	# START server2 SETTINGS SECTION
	
		config.vm.define "server2" do |server2|
			server2.vm.hostname = server2_hostname +'.'+ server2_domain
			server2.vm.network "private_network", ip: server2_private_ip
			server2.vm.provider "virtualbox" do |server2|
				server2.gui = true
			end

			#START server2 PROVISION SECTION

			server2.vm.provision "shell", inline: <<-SHELL
				yum install -y git
				cd ~
				git clone https://github.com/SergeyKvyatkovsky/DevOps_Training.git
				cd DevOps_Training
				git checkout ModulTwo
				more text.txt
				ssh-keygen -q -b 2056 -t rsa -N password -C My_comment -f vagrant_key_ssh
				ssh-copy-id -f vagrant@192.168.1.5
				echo PasswordAuthentication no >> /etc/ssh/sshd_config
			SHELL

		end

	end