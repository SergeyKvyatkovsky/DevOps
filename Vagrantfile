# GLOBAL VARIABLES
os_srv = 'centos/7'
domain = 'local'
server1_hostname = 'host1'
server2_hostname = 'host2'
server3_hostname = 'host3'
server1_private_ip = '192.168.1.5'
server2_private_ip = '192.168.1.6'
server3_private_ip = '192.168.1.7'

	Vagrant.configure("2") do |config|

		#GLOBAL SETTINGS

		config.vm.box = os_srv
		config.vm.provision "shell", inline: <<-SHELL

			#DISABLE FIREWALL

			systemctl stop firewalld

			#SET GLOBAL DNS (crutch)

			echo 192.168.1.5 host1.local.home.lan dnsserverer >> /etc/hosts
			echo 192.168.1.6 host2.local.home.lan >> /etc/hosts
			echo 192.168.1.7 host3.local.home.lan >> /etc/hosts

		SHELL


		# FIRST SERVER TOMCAT

		# START server1 SETTINGS SECTION


		config.vm.define "web-server-tomcat1" do |server1|

		server1.vm.network "forwarded_port", guest: 80, host: 8081
			server1.vm.hostname = server1_hostname +'.'+ domain
			server1.vm.network "private_network", ip: server1_private_ip
			server1.vm.synced_folder "sync" , "/sync" , type:"rsync"
			server1.vm.provider "virtualbox" do |server1|
				server1.gui = true
			end

		# START server1 PROVISION SECTION

			server1.vm.provision "shell", inline: <<-SHELL
				yum install -y mc
				yum install -y git
				yum install -y tomcat-webapps tomcat-admin-webapps
				sudo systemctl enable tomcat
				sudo systemctl restart tomcat
				chown vagrant /usr/share/tomcat -R
				cd /usr/share/tomcat/webapps
				mkdir test
				cd test
				echo web-server-first > index.html
				sudo systemctl restart tomcat

			SHELL

		end

		# SECOND SERVER TOMCAT

		# START server2 SETTINGS SECTION

		config.vm.define "web-server-tomcat2" do |server2|
			server2.vm.network "forwarded_port", guest: 80, host: 8082
			server2.vm.hostname = server2_hostname +'.'+ domain
			server2.vm.network "private_network", ip: server3_private_ip
			server2.vm.synced_folder "sync" , "/sync" , type:"rsync"
			server2.vm.provider "virtualbox" do |server2|
				server2.gui = true
			end

		# START server2 PROVISION SECTION

			server2.vm.provision "shell", inline: <<-SHELL
				yum install -y mc
				yum install -y git
				yum install -y tomcat-webapps tomcat-admin-webapps
				sudo systemctl enable tomcat
				sudo systemctl restart tomcat
				chown vagrant /usr/share/tomcat -R
				cd /usr/share/tomcat/webapps
				mkdir test
				cd test
				echo web-server-second > index.html
				sudo systemctl restart tomcat

			SHELL

		end

		# SERVER-BALANCER

		# START server3 SETTINGS SECTION

		config.vm.define "apatch_httpd-server-balancer" do |server3|
			server3.vm.hostname = server3_hostname +'.'+ domain
			server3.vm.network "forwarded_port", guest: 80, host: 8083
			server3.vm.network "private_network", ip: server2_private_ip
			server3.vm.synced_folder "sync","/sync",type:"rsync"
			server3.vm.provider "virtualbox" do |server3|
				server3.gui = true
			end

			#START server3 PROVISION SECTION

			server3.vm.provision "shell", inline: <<-SHELL
				yum install -y git
				yum install -y httpd
				systemctl stop firewalld
				git clone https://github.com/SergeyKvyatkovsky/DevOps_Training.git
				cd DevOps_Training
				git checkout ModulThree
				cp mod_jk.so /etc/httpd/modules/
				echo worker.list=lb > /etc/httpd/conf/workers.properties
				echo worker.lb.type=lb >> /etc/httpd/conf/workers.properties
				echo worker.lb.balance_workers=myworker,other >> /etc/httpd/conf/workers.properties
				echo worker.myworker.host=192.168.1.5 >> /etc/httpd/conf/workers.properties
				echo worker.myworker.port=8009 >> /etc/httpd/conf/workers.properties
				echo worker.myworker.type=ajp13 >> /etc/httpd/conf/workers.properties
				echo worker.other.host=192.168.1.7 >> /etc/httpd/conf/workers.properties
				echo worker.other.port=8009 >> /etc/httpd/conf/workers.properties
				echo worker.other.type=ajp13 >> /etc/httpd/conf/workers.properties
				echo " " >> /etc/httpd/conf/httpd.conf
				echo "LoadModule jk_module /etc/httpd/modules/mod_jk.so" >> /etc/httpd/conf/httpd.conf
				echo "JkWorkersFile /etc/httpd/conf/workers.properties" >> /etc/httpd/conf/httpd.conf
				echo "JkShmFile /tmp/shm" >> /etc/httpd/conf/httpd.conf
				echo "JkLogFile logs/mod_jk.log" >> /etc/httpd/conf/httpd.conf
				echo "JkLogLevel info" >> /etc/httpd/conf/httpd.conf
				echo "JkMount /test* lb" >> /etc/httpd/conf/httpd.conf
				systemctl restart httpd
			SHELL

		end

	end