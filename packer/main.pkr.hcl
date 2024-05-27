packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  ami_full_name = "${var.image_name}${var.image_version}"
}

source "amazon-ebs" "nginx-ami" {
  ami_name      = local.ami_full_name 
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = var.golden_ami_name
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["905418400291"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "nginx"
  sources = [
    "source.amazon-ebs.nginx-ami"
  ]

  provisioner "shell" {
  script       = "script.sh"
  pause_before = "30s"
  timeout      = "120s"
}

  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
    custom_data = {
      ami_name = local.ami_full_name
    }
  }
}
