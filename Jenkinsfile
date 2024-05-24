@Library("opstree-shared-library@immutable-infra") _

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    cleanWs()
    stage('GIT Checkout'){
        gitClone.repoCloning(        
            REPO_URL : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
            REPO_CREDS : 'github-token',
            REPO_BRANCH : 'aws-Immutable-Infra')
        
    }
    stage('clone 2'){
        gitClone.repoClone()    
    }
    
    // deployment.runPacker(config.packer)
}