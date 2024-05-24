@Library("opstree-shared-library@immutable-infra") _

import groovy.json.JsonSlurper
def config = readYaml file: './config.yaml'

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {
    // def config = readYaml file: './config.yaml'

    // def deploymentConfig = load 'config.yaml'
    def gitParams = config.git
    def packerParams = config.packer
    deployment.call(git: gitParams, packer: packerParams)
}

