@Library("opstree-shared-library@infraDeploy") _

def startDeployment = new org.opstree.template.deployInfra.deployInfra()

node {

    // GIT
    // def gitCheckout = true
    // def url = 'https://github.com/HarshitSingh-Codes/0T-packer.git'
    // def creds = 'github-token'
    // def branch = 'nginxV1.0'

    // Packer
    // def runPacker = true
    // def rootFolderNAme = ''
    // def packerFileName = '.'
    // def amiVersion = '0.4'
    
    

    startDeployment.call([
        // GIT
        gitCheckout : false, 
        url : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
        creds : 'github-token',
        branch : 'nginxV1.0',

        // Packer
        runPacker : false,
        goldenAmiName : 'golden-ami',
        amiName : 'nginx',
        amiVersion : '0.5',
        rootFolderName : 'nginx',
        packerFileName : 'nginx.pkr.hcl',

        // Launch template
        updateLaunchTemplate : true,
        templateID : 'lt-040f6fff0e3a3b0cd',
        sourceVersion : '1',
        versionDescription : 'ami via packer and jenkins'

        // ASG
        startInstanceRefresh : true
        asgConfigRootdir : '.'
        asgConfigFilename : 'config.json'

        ])
}
