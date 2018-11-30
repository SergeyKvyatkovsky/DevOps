#
# Cookbook:: admintools
# Recipe:: default
#
# Copyright:: 2018, by Serg Kv, All Rights Reserved.
#default["ip"]["port"]["pack"]={"ip" => 192.168.99.100,"port" => 5000, "pack" => "nmap"}


package 'nmap' do  
   action :install
end

yum_repository 'docker-ce' do
   name "docker-ce"
   baseurl 'https://download.docker.com/linux/centos/7/x86_64/stable'
   gpgcheck true
   gpgkey 'https://download.docker.com/linux/centos/gpg'
   enabled true
   action :create
end
package 'Install Docker-ce' do
   package_name 'docker-ce'
   action [:install]
end
directory '/etc/docker' do
   owner 'root'
   group 'root'
   mode '0777'
   action :create
end
file '/etc/docker/daemon.json' do
   content '{  "insecure-registries" : ["192.168.99.100:5000"]  }'
   mode '0777'
   owner 'root'
   group 'root'
end
service "docker" do
   action [:enable,:start]
end
