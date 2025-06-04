pipeline {
    agent any

    environment {
        IMAGE_NAME = 'shaharprofeta/fastapi-hello'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Cleanup') {
            steps {
                script {
                    try {
                        sh 'docker rm -f fastapi-app || true'
                    } catch (Exception e) {
                        echo 'No container to remove'
                    }
                }
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        docker push ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Run Docker container') {
            steps {
                script {
                    sh """
                        docker run -d \
                            --name fastapi-app \
                            -p 8000:8000 \
                            ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                    
                    // Health check
                    sh '''
                        for i in {1..30}; do
                            if curl -s http://localhost:8000/; then
                                echo "Application is up!"
                                exit 0
                            fi
                            sleep 2
                        done
                        echo "Application failed to start!"
                        exit 1
                    '''
                }
            }
        }
    }

    post {
        failure {
            sh 'docker rm -f fastapi-app || true'
        }
    }
}
