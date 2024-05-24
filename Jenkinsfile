@Library("opstree-shared-library@immutable-infra") _

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    cleanWs()
    gitUtils.gitCheckout(        
            REPO_URL : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
            REPO_CREDS : 'github-token',
            REPO_BRANCH : 'aws-Immutable-Infra')
    // deployment.runPacker(config.packer)
}