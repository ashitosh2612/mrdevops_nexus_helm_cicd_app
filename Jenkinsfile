pipeline{
    agent any
    stages{
        stage("git checkout "){
            steps{
           git branch: 'main', url: 'https://github.com/ashitosh2612/mrdevops_nexus_helm_cicd_app.git'
            }
            
        }
    }

    stage("sonar qube quality check"){
        agent{
            docker {
                image 'maven'
            }
        }
        steps{
            script{
                withSonarQubeEnv(credentialsId: 'sonar') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }

    }
    
}