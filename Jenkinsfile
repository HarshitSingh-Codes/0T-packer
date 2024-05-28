@Library("opstree-shared-library@packer-ami") _

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    checkout scm

    def config = readYaml file: './config.yaml' 
    deployment.runPacker(config.packer)
    // deployment.updateLaunchTemplate(config.launch_template)
}