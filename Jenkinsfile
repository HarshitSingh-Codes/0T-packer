@Library("opstree-shared-library@immutable-infra") _

import groovy.json.JsonSlurper

def deployment = new org.opstree.template.awsImmutableInfraAppDeployer.awsImmutableInfraAppDeployer()

node {
    def deploymentConfig = load 'config.yaml'
    def gitParams = deploymentConfig.git
    def packerParams = deploymentConfig.packer
    deployment.call(git: gitParams, packer: packerParams)
}