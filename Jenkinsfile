@Library("opstree-shared-library@harshit/rolling-shared-library") _

def startDeployment = new org.opstree.template.deployInfra.deployInfra()

node {
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
        updateLaunchTemplate : false,
        templateID : 'lt-040f6fff0e3a3b0cd',
        sourceVersion : '1',
        versionDescription : 'ami via packer and jenkins',

        // ASG
        startInstanceRefresh : true,
        asgConfigRootdir : '.',
        asgConfigFilename : 'config.json'

        ])
}
