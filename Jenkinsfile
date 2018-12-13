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
		script{

			def multiline = readFile encoding: 'UTF-8', file: '${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/metadata.rb'
			def splitOne
			def oldVersion
			def splitTwo
			def iti
			def txtFileInfo = []
			def directory = '${env.WORKSPACE}'
			def folderName = '/DevOps_Training-ModulTen/cookbooks/admintools/'
			def c

			multiline.eachLine {
				if (it =~ /version/) {
					println it  // Output: Groovy
					iti = it
					splitOne = it.split("version 0.1.")
					splitTwo = splitOne[1].split(" ")
					String r = splitTwo[0]
					oldVersion = splitTwo[0]
					println oldVersion
				}
			} 
			println oldVersion
			String gg = oldVersion
			def writeInFile = iti.replaceAll("1.0." + gg,${versionGlobal})
			println writeInFile
			txtFileInfo << writeInFile
			println txtFileInfo
			c = createFolder(directory,folderName)
			writeToFile(c, "metadata", ".rb", txtFileInfo)
		}
		script{

			def multiline = readFile encoding: 'UTF-8', file: '${env.WORKSPACE}/DevOps_Training-ModulTen/cookbooks/admintools/attributes/default.rb'
			def splitOne
			def oldVersion
			def splitTwo
			def iti
			def txtFileInfo = []
			def directory = '${env.WORKSPACE}'
			def folderName = '/DevOps_Training-ModulTen/cookbooks/admintools/attributes/'
			def c

			multiline.eachLine {
				if (it =~ /default[\'docker\'][\'tag\'] = \'1.0./) {
					println it  // Output: Groovy
					iti = it
					splitOne = it.split("default[\'docker\'][\'tag\'] = \'1.0.")
					splitTwo = splitOne[1].split("\'")
					String r = splitTwo[0]
					oldVersion = splitTwo[0]
					println oldVersion
				}
			} 
			println oldVersion
			String gg = oldVersion
			def writeInFile = iti.replaceAll("1.0." + gg,${versionGlobal})
			println writeInFile
			txtFileInfo << writeInFile
			println txtFileInfo
			c = createFolder(directory,folderName)
			writeToFile(c, "default", ".rb", txtFileInfo)
		}
		
		script{

			def multiline = readFile encoding: 'UTF-8', file: '${env.WORKSPACE}/DevOps_Training-ModulTen/environments/ENVIRONMENT.json'
			def splitOne
			def oldVersion
			def splitTwo
			def iti
			def txtFileInfo = []
			def directory = '${env.WORKSPACE}'
			def folderName = '/DevOps_Training-ModulTen/environments/'
			def c

			multiline.eachLine {
				if (it =~ /\"admintools\": \"/) {
					println it  // Output: Groovy
					iti = it
					splitOne = it.split("\"admintools\": \"")
					splitTwo = splitOne[1].split("\"")
					String r = splitTwo[0]
					oldVersion = splitTwo[0]
					println oldVersion
				}
			} 
			println oldVersion
			String gg = oldVersion
			def writeInFile = iti.replaceAll("1.0." + gg,${versionGlobal})
			println writeInFile
			txtFileInfo << writeInFile
			println txtFileInfo
			c = createFolder(directory,folderName)
			writeToFile(c, "default", ".rb", txtFileInfo)
		}

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