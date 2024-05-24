@Library("opstree-shared-library@immutable-infra") _

// import groovy.json.JsonSlurper
// def config = readYaml file: './config.yaml'

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {

    def gitParams = [ url : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
        creds : 'github-token',
        branch : 'aws-Immutable-Infra' ]
    deployment.gitCheckout(gitParams)

    // def config = readYaml file: './config.yaml'
    // def packerParams = config.packer
    // deployment.call(git: gitParams, packer: packerParams)
}