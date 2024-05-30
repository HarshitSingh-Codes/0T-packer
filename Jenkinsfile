@Library("opstree-shared-library@immutable-infra") _

def appDeployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    checkout scm
    
    def config_dir = '.' 
    def config_filename =  'config.yaml'

    appDeployment.call(dir : ${config_dir}, file : ${config_filename})
}