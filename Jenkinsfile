pipeline {
    agent any
    
    // environment {
    //     AWS_ACCESS_KEY_ID     = credentials('Frontend Creds')
    //     AWS_SECRET_ACCESS_KEY = credentials('Frontend Creds')
    //     TF_CLI_ARGS           = '-input=false'
    // }
    
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose to apply or destroy the infrastructure')
        string (defaultValue: 'nginx-v1-ami', description: 'AMI name to use in the Launch Template ', name: 'amiName')

    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: 'nginxV1.0']], extensions: [], userRemoteConfigs: [[credentialsId: 'github-token', url: 'https://github.com/HarshitSingh-Codes/0T-packer.git']])            }
        }
        
        // stage('Copy Terraform Files') {
        //     steps {
        //         // Copy or move specific files from the repository to Jenkins workspace
                
        //         sh 'cd Dev_Infra/Static_Tf/Frontend/* .'
        //     }
        // }
        
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
                    sh 'cd launch-template/ && terraform plan -var ami_name="' + params.amiName + '"'
                }
            }
        }
        
        stage('Review and Approve Apply') {
            when {
                expression { params.ACTION == 'Apply' }
            }
            steps {
                // Prompt for approval before applying changes
                input "Do you want to apply Terraform changes?"
            }
        }
        
        stage('Review and Approve Destroy') {
            when {
                expression { params.ACTION == 'Destroy' }
            }
            steps {
                // Prompt for approval before destroying resources
                input "Do you want to destroy Terraform resources?"
            }
        }
        
        stage('Apply or Destroy') {
            steps {
                script {
                    if (params.ACTION == 'Apply') {
                        sh 'cd launch-template/ && terraform apply -var ami_name="' + params.amiName + '" -auto-approve'
                    } else if (params.ACTION == 'Destroy') {
                        sh 'cd launch-template/ && terraform destroy -var ami_name="' + params.amiName + '" -auto-approve'
                    }
                }
            }
        }
    }

}
