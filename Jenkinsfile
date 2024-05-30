@Library("opstree-shared-library@immutable-infra") _

def appDeployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    checkout scm
    
    appDeployment.template(dir:".", file:"config.yaml")
}