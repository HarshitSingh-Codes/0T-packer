@Library("opstree-shared-library@packer+aws-cli") _

def opstree = new org.opstree.template.nginx.nginx()

node {

    // GIT
    def url = 'https://github.com/HarshitSingh-Codes/0T-packer.git'
    def creds = 'github-token'
    def branch = 'nginxV1.0'
    
    // Packer
    def packerFileName = '.'
    def amiVersion = '0.3'
    
    // Launch template
    def templateID = 'lt-040f6fff0e3a3b0cd'
    def sourceVersion = '1'
    def versionDescription = 'default'
    
    // ASG config file
    def asgConfig = 'config.json'

    opstree.checkout(url, creds, branch)

    opstree.runPacker(packerFileName, amiVersion)

    opstree.updateLaunchTemplate(templateID, sourceVersion, versionDescription)

    opstree.instanceRefresh(asgConfig)
}
