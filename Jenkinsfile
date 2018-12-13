def versionGlobal
def versionN

node('Chef') {
	stage('Chef') {
		git branch: 'ModulTen', credentialsId: '637dcd76-0c3a-4df7-bcef-93e659af507f', url: 'https://github.com/SergeyKvyatkovsky/DevOps_Training.git'

		script{
			versionN = readFile encoding: 'UTF-8', file: '${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/metadata.rb'
			def emptyList = []
			def menulist = []
			def list = []
			def listt = []

			emptyList = versionN.split("version")
			println emptyList
			menulist = emptyList[1].split(' ')
			println menulist[1]
			list = menulist[1].split("0.1.")
			println list
			listt = list[1].split("'")
			println listt[0]
			String s = listt[0]
			println s
			int value = s.toInteger()
			versionGlobal = value + 1
			println versionGlobal
		}
	}

	stage('UpdateVersion') {
		sh 'echo "name \'admintools\'" > ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "maintainer \'The Authors\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "maintainer_email \'you@example.com\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "description \'Installs/Configures admintools\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "long_description \'Installs/Configures admintools\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "version \'0.1.${versionGlobal}\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
		sh 'echo "chef_version \'>= 12.1\' if respond_to?(:chef_version)" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'

		sh 'echo "default[\'docker\'][\'subnet\']=\'192.168.99\'" > ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'portOne\']=\'8080\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'portTwo\']=\'8081\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'tag\'] = \'1.0.${versionGlobal}\'" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/attributes/default.rb'

		sh 'echo "{" >> ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"name\": \"testenv\"," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"description\": \"\"," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"cookbook_versions\": {" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"admintools": \"= 1.0.${versionGlobal}\",\" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"docker\": \">= 1.0.0\"" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "}," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"json_class\": \"Chef::Environment\"," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"chef_type\": \"environment\"," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo " \"default_attributes\": {" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "}," > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "\"override_attributes\": {" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "}" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
		sh 'echo "}" > ${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'

	}
	stage('ChefDeploy') {
		sh 'knife cookbook upload -a'
		sh 'chef-client'
	}
	stage('ChefPush') {
		sh "git checkout ModulTen"
		sh "git add ."
		sh 'git commit -m "mod10 update"'
		withCredentials([usernamePassword(credentialsId: 'git', passwordVariable: 'pswrd', usernameVariable: 'usr')]) {
			sh "git push https://${usr}:${pswrd}@github.com/SergeyKvyatkovsky/DevOps_Training.git"
			sh "git push https://${usr}:${pswrd}@github.com/SergeyKvyatkovsky/DevOps_Training.git"
		}
	}
}