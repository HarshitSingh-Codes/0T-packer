packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
function clean_ami_name(name) {
  // Replace invalid characters with underscores
  name = replace(name, "[^a-zA-Z0-9().-_]", "_")

  // Remove leading and trailing underscores
  name = trim(name, "_")

  // Ensure the name is at most 128 characters long
  name = substr(name, 0, 128)

  return name
}
locals {
  ami_base_name = "${var.image_name}_${var.image_version}"
  ami_full_name = "${clean_ami_name(local.ami_base_name)}-${timestamp()}"
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
