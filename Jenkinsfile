pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ShaharProfeta/fastapi-hello'
        TAG = 'latest'
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                git 'https://github.com/ShaharProfeta/HomeWorkProject.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${IMAGE_NAME}:${TAG}
                        """
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                withCredentials([file(credentialsId: 'fastapi-env', variable: 'ENV_FILE')]) {
                    script {
                        sh "docker rm -f fastapi-app || true"
                        sh "docker run -d --name fastapi-app --env-file $ENV_FILE -p 8000:8000 ${IMAGE_NAME}:${TAG}"
                    }
                }
            }
        }
    }
}
