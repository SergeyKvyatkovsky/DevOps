# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
default["starter_name"] = "Sam Doe"
default['docker']['subnet']='192.168.99'
default['docker']['portOne']='8080'
default['docker']['portTwo']='8081'
default['docker']['tag'] = '1.0.4'
default["portOne"]="8080"
default["portTwo"]="8081"
default["DockerSubnet"]="192.168.99"
# For further information, see the Chef documentation (https://docs.chef.io/essentials_cookbook_attribute_files.html).
