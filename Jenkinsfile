pipeline {
    agent any //{ label 'Java-built-node'}
     tools {
        maven 'Maven' 
        dockerTool 'docker'
        }
    stages {
        stage("Test"){
            steps{
                // mvn test
                sh "mvn test"
                echo "Test Complete"
                
            }
            
        }
        stage("Build"){
            steps{
                sh "mvn package"
                echo "Build Complete"
                
            }
            
        }
        stage("Deploy on Test"){
            steps{
                // deploy on container -> plugin
                deploy adapters: [tomcat9(credentialsId: 'tomcatserverdetails', path: '', url: 'http://3.80.177.255:8080')], contextPath: '/app', war: '**/*.war'
                echo "Deployed on Test"
              
            }
            
        }
        stage("Deploy on Prod"){
             input {
                message "Should we continue to Prod?"
                ok "Yes"
            }
            
            steps{
                // deploy on container -> plugin
                deploy adapters: [tomcat9(credentialsId: 'tomcatserverdetails', path: '', url: 'http://3.80.177.255:8080')], contextPath: '/app2', war: '**/*.war'
                echo "Deployed on Production"

            }
        }
        stage("Build Docker Image") {
           steps{
               script{
                   sh 'docker build -t varadk05/spring-boot-war-example .'
               }
           }
        }
        stage("Push image to Dockerhub") {
            steps{
                script {
                    withCredentials([string(credentialsId:'dockerhub-pwd', variable:'dockerhubpwd')]) {
                        sh 'docker login -u varadk05 -p ${dockerhubpwd}'
                    }
                    sh 'docker push varadk05/spring-boot-war-example'
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
