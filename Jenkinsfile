pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shaharprofeta/fastapi-hello'
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                git 'https://github.com/ShaharProfeta/HomeWorkProject.git'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push $IMAGE_NAME
                    """
                }
            }
        }

        stage('Run Docker container') {
            steps {
                sh 'docker run -d -p 8000:8000 $IMAGE_NAME'
            }
        }
    }
}
