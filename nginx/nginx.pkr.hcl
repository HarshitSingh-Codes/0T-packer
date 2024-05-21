packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "golden_ami_name" {
  type    = string
  default = "golden-ami"
}

variable "image_name" {
  type    = string
  default = "nginx"
}

variable "image_version" {
  type    = string
  default = "0.1"
}

variable "filePath" {
  type    = string
  default = "index1.html"
}
locals {
  # Ids for multiple sets of EC2 instances, merged together
  ami_full_name = "${var.image_name}${var.image_version}"
}
source "amazon-ebs" "nginx-ami" {
  ami_name      = local.ami_full_name 
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = var.golden_ami_name
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["975049907153"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "nginx"
  sources = [
    "source.amazon-ebs.nginx-ami"
  ]
  provisioner "shell" {
    inline = [
      "sudo chown -R ubuntu:ubuntu /var/www/html/",
    ]
  }

  provisioner "file" {
    source      = var.filePath
    destination = "/var/www/html/index.nginx-debian.html"

  }
  provisioner "shell" {

    inline = [
      "sudo chown -R root:root /var/www/html/",
      "echo Restart NGINX",
      "sudo systemctl restart nginx.service",
      "sudo systemctl status nginx.service",
    ]
  }
  post-processor "manifest" {
    output = "manifest.json"
    strip_path = true
    custom_data = {
      ami_name = local.ami_full_name
    }
  }
}
