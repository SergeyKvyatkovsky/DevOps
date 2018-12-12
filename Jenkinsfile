def versionGlobal
def versionN

node('Chef') {
	stage('Chef') {
		git branch: 'ModulTen', credentialsId: '637dcd76-0c3a-4df7-bcef-93e659af507f', url: 'https://github.com/SergeyKvyatkovsky/DevOps_Training.git'

		script{
			versionN = readFile encoding: 'UTF-8', file: '/root/workspace/task10(Test)/cookbooks/metadata.rb'
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
		sh 'echo "name \'admintools\'" > /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "maintainer \'The Authors\'" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "maintainer_email \'you@example.com\'" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "description \'Installs/Configures admintools\'" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "long_description \'Installs/Configures admintools\'" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "version \'0.1.${versionGlobal}\'" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'
		sh 'echo "chef_version \'>= 12.1\' if respond_to?(:chef_version)" >> /root/workspace/task10(Test)/cookbooks/admintools/metadata.rb'

		sh 'echo "default[\'docker\'][\'subnet\']=\'192.168.99\'" > /root/workspace/task10(Test)/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'portOne\']=\'8080\'" >> /root/workspace/task10(Test)/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'portTwo\']=\'8081\'" >> /root/workspace/task10(Test)/cookbooks/admintools/attributes/default.rb'
		sh 'echo "default[\'docker\'][\'tag\'] = \'1.0.${versionGlobal}\'" >> /root/workspace/task10(Test)/cookbooks/admintools/attributes/default.rb'

		sh 'echo "{" >> /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"name\": \"testenv\"," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"description\": \"\"," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"cookbook_versions\": {" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"admintools": \"= 1.0.${versionGlobal}\",\" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"docker\": \">= 1.0.0\"" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "}," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"json_class\": \"Chef::Environment\"," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"chef_type\": \"environment\"," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo " \"default_attributes\": {" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "}," > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "\"override_attributes\": {" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "}" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'
		sh 'echo "}" > /root/workspace/task10(Test)/environments/ENVIRONMENT.json'

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