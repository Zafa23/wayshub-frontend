def branch = "main"
def repo = "https://github.com/Zafa23/wayshub-frontend.git"
def cred = "appserver"
def dir = "~/wayshub-frontend"
def server = "zafar@103.82.92.255"
def imagename = "wayshub-fe"
def dockerusername = "zafarassidiq"

pipeline {
    agent any

    stages {
        stage('Pull From Repository') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        git remote add origin ${repo} || git remote set-url origin ${repo}
                        git pull origin ${branch}
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Dockerize') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker build -t ${imagename}:latest .
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Deploy Docker') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        cd ${dir}
                        docker stop ${imagename} || true
                        docker rm ${imagename} || true
                        docker run -d -p 3000:3000 --name=${imagename} ${imagename}:latest
                        exit
                        EOF
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sshagent([cred]) {
                    sh """ssh -o StrictHostKeyChecking=no ${server} << EOF
                        docker tag ${imagename}:latest ${dockerusername}/${imagename}:latest
                        docker login -u ${dockerusername} -p DOCKER_PASSWORD
                        docker push ${dockerusername}/${imagename}:latest
                        exit
                        EOF
                    """
                }
            }
        }
    }
}

