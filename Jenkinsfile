@Library("opstree-shared-library@immutable-infra") _

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    // def gitParams = [ url : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
    //     creds : 'github-token',
    //     branch : 'aws-Immutable-Infra' ]
    // deployment.gitCheckout(gitParams)

    def config = readYaml file: './config.yaml'

    deployment.gitCheckout(config.git)
    
    deployment.runPacker(config.packer)
}