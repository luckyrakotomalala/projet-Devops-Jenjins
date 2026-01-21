pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Infrastructure - Terraform') {
            steps {
                dir('terraform') {
                    bat'terraform init'
                    bat'terraform apply -auto-approve'
                }
            }
        }

        stage('Security Scan - Trivy') {
            steps {
                bat 'trivy config App_front/'
                bat 'trivy config App_back/'
            }
        }

        stage('Build & Push Docker') {
            steps {
                bat 'docker-compose build'
                bat 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                bat 'docker-compose push'
            }
        }

        stage('Configuration - Ansible') {
            steps {
                bat'ansible-playbook -i inventory.ini playbook.yml'
            }
        }
    }
}
