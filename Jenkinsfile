@Library("opstree-shared-library@packer-ami") _

def appDeployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    checkout scm
    
    appDeployment.call(dir:".", file:"config.yaml")
}