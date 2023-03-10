pipeline {

    environment {
        imageName = "anatollucky/falcon-demo-app:${env.BUILD_ID}"
        customImage = ""
    }
    
    agent any

    stages {
        
        stage("Start container for Testing") {
            steps {
                script {
                    sh 'docker-compose rm -f; docker-compose up -d images'
                }
            }
        }

        stage("Run tests") {
            steps {
                script {
                    sh "pip3 install -r requirements.txt; python3 -m pytest tests"
                }
            }
            post {

                success {
                    script {
                        sh "docker-compose down"
                    }
                }
        
                failure {
                    script {
                        sh "docker-compose down"
                    }
                }
            }
        }
        stage("Build image") {
            steps {
                script { 
                    customImage = docker.build(imageName)
                }
            }
        }
        
        stage("Push to registry") {
            when {
                branch "main"
            }
            steps {
                script {
                    withDockerRegistry(credentialsId: 'dockerhub-token', url: 'https://index.docker.io/v1/') {
                        customImage.push()
                    }
                }
            }
        }
    }
}