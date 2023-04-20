pipeline{
    agent any
    environment{
        VERSION= "${env.BUILD_ID}"
    }
    stages{
        stage("git checkout "){
            steps{
           git branch: 'main', url: 'https://github.com/ashitosh2612/mrdevops_nexus_helm_cicd_app.git'
            }
            
        }
         stage("sonar qube quality check"){
            steps{
            script{
                withSonarQubeEnv(credentialsId: 'sonar') {
                    sh 'mvn clean package sonar:sonar'
                }
                }
              }

           }
            /*stage("sonar qube quality gate check"){
            steps{
            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
              }

           }*/

           stage("docker image build and push to nexus repo"){
            steps{
                withCredentials([string(credentialsId: 'nexus_pass', variable: 'nexus_cred')]) {
                sh """
                docker build -t 35.234.255.246:8083/spring-application:${VERSION} .
                docker login -u admin -p ${nexus_cred} 35.234.255.246:8083
                docker push 35.234.255.246:8083/spring-application:${VERSION} 
                docker rmi 35.234.255.246:8083/spring-application:${VERSION} 
                """
                }
            }
           }
         stage("Identify misconfigration using datree in helm charts"){
            steps{
                script{
                dir('kubernetes/myapp/') {
                    withEnv(['DATREE_TOKEN=816bf8fc-1d30-49ef-885e-bf7df07e520d']) {
                 sh 'helm datree test .'
                }
                }
            }
            }
         }

    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "ashitosh.rakshe2612@gmail.com";  
		}
	}
}