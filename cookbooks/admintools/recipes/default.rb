
# Cookbook:: admintools
# Recipe:: default
#
# Copyright:: 2018, by Serg Kv, All Rights Reserved.
#default["ip"]["port"]["pack"]={"ip" => 192.168.99.100,"port" => 5000, "pack" => "nmap"}


package 'nmap' do
   action :install
end

def check_port(port)
 begin
 require 'net/http'
 response = nil
 Net::HTTP.start('192.168.0.66',port) {|http|
  response = http.head('/gradleSample/')
 }
 puts response.code
 code = response.code
 return code
 rescue
 puts 0
 return 0
 end
 
end

code = check_port(node['docker']['portOne'])
codeTwo = check_port(node['docker']['portTwo'])


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
   content '{  "insecure-registries" : ["#{node['docker']['subnet']}.100:5000"]  }'
   mode '0777'
   owner 'root'
   group 'root'
end

service "docker" do
   action [:enable,:start]
end

case (code <=> codeTwo)

  when -1
    execute 'upCon' do
      puts -1
      command "cd ~"
      command "docker run --name tomcatwithappez -d -p 8080:8080 tomcatwithapp"
      command "docker stop tomcatwithappeo"
      command "docker rm tomcatwithappeo"
    end

    docker_container "tomcatwithappez" do
      repo "192.168.99.100:5000/gradleSample/"
      tag "#{node['docker']['tag']}"
      port "8080:8080"
      action :redeploy
    end

  when 1
    execute 'upCont' do
      puts 1
      command "cd ~"
      command "docker run --name tomcatwithappeo -d -p 8081:8080 tomcatwithapp"
      command "docker stop tomcatwithappez"
      command "docker rm tomcatwithappez" 
    end

    docker_container "tomcatwithappeo" do
      repo "192.168.99.100:5000/gradleSample"
      tag "#{node['docker']['tag']}"
      port "8081:8080"
      action :redeploy
    end

 when 0
    execute 'whenZero' do
      puts 0
      command "docker run --name tomcatwuthappez -d -p 8080:8080 tomcatwithapp"
    end

    docker_container "tomcatwithappez" do
      repo "192.168.99.100:5000/gradleSample"
      tag "#{node['docker']['tag']}"
      port "8080:8080"
      action :redeploy
    end
end


docker_image "192.168.99.100:5000/gradleSample" do
  tag "#{node['docker']['tag']}"
  action :pull
end
