pipeline {
    agent any
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
        string (defaultValue: 'nginx-v1-ami', description: 'AMI name to use in the Launch Template ', name: 'amiName')

    }
    environment { 
        TF_VAR_ami_name = "'${params.amiName}'"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: 'nginxV1.0']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/HarshitSingh-Codes/0T-packer.git']])            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'cd launch-template/ && terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'cd launch-template/ && terraform plan'
                }
            }
        }
        
        stage('Review and Approve Apply') {
            when {
                expression { params.ACTION == 'Apply' }
            }
            steps {
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Review and Approve Destroy') {
            when {
                expression { params.ACTION == 'Destroy' }
            }
            steps {
                input "Do you want to destroy Terraform resources?"
            }
        }
        
        stage('Apply or Destroy') {
            steps {
                script {
                    if (params.ACTION == 'Apply') {
                        sh "cd launch-template/ && terraform apply -auto-approve"
                    } else if (params.ACTION == 'Destroy') {
                        sh "cd launch-template/ && terraform destroy -auto-approve"
                    }
                }
            }
        }
    }
}
