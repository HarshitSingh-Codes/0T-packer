packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "nginx-ami" {
  ami_name      = "nginx-v2-ami"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami_filter {
    filters = {
      name                = "golden-ami"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["975049907153"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "nginx-v2"
  sources = [
    "source.amazon-ebs.nginx-ami"
  ]
  provisioner "shell" {
    inline = [
      "sudo chown -R ubuntu:ubuntu /var/www/html/",
    ]
  }

  provisioner "file" {
    source      = "./index.html"
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
}