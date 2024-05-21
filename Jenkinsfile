@Library("opstree-shared-library@packer+aws-cli") _

def startDeployment = new org.opstree.template.deployInfra.deployInfra()

node {

    // GIT
    def gitCheckout = true
    def url = 'https://github.com/HarshitSingh-Codes/0T-packer.git'
    def creds = 'github-token'
    def branch = 'nginxV1.0'

    // Packer
    def runPacker = true
    def rootFolderNAme = ''
    def packerFileName = '.'
    def amiVersion = '0.4'
    
    // Launch template
    def updateLaunchTemplate = true
    def templateID = 'lt-040f6fff0e3a3b0cd'
    def sourceVersion = '1'
    def versionDescription = 'default'
    
    // ASG config file
    def startInstanceRefresh = true
    def asgConfig = 'config.json'

    startDeployment.call([
        // GIT
        gitCheckout : true, 
        url : 'https://github.com/HarshitSingh-Codes/0T-packer.git',
        creds : 'github-token',
        branch : 'nginxV1.0'
        ])
}
