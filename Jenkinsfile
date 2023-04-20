pipeline{
    agent any
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
            stage("sonar qube quality gate check"){
            steps{
            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
              }

           }
    
    }
}