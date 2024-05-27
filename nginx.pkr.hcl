
// packer init .
// packer fmt .
// packer validate .
// packer build golden-ami.pkr.hcl
// packer build \
//   -var "weekday=Sunday" \
//   -var "flavor=chocolate" \
//   -var "sudo_password=hunter42" .
// packer build -on-error=ask golden-ami.pkr.hcl 2>&1 | tee packer.log
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "frontend-app" {
  ami_name      = "golden-ami"
  instance_type = "t2.micro"
  region        = "us-east-1"
  // subnet_id = "subnet-12345678"
  // vpc_id = "vpc-12345678"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "nginx-golden-ami"
  sources = [
    "source.amazon-ebs.frontend-app"
  ]

  provisioner "shell" {

    inline = [
      "echo Installing Pre-requisites",
      "sudo apt-get update",
      "sudo apt-get install openjdk-17-jre-headless -y",
      "sudo apt-get install nginx -y",
    ]
  }

}
