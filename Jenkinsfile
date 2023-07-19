def repo = "https://github.com/Zafa23/wayshub-frontend.git"
def dir = "wayshub-frontend"
def imagename = "wayshub-fe"
def dockerusername = "zafarassidiq"
def dockerpassword = "Zafar250104"

pipeline {
    agent any

    stages {
        stage('Pull From Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: "${repo}"]]])
            }
        }

        stage('Dockerize') {
            steps {
                sh "docker build -t ${imagename}:latest ${dir}"
            }
        }

        stage('Deploy Docker') {
            steps {
                sh "docker run -d -p 80:80 --name=${imagename} ${imagename}:latest"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-credentials', url: '') {
                    sh "docker login -u ${dockerusername} -p ${dockerpassword}"
                    sh "docker tag ${imagename}:latest ${dockerusername}/${imagename}:latest"
                    sh "docker push ${dockerusername}/${imagename}:latest"
                }
            }
        }
    }
}

