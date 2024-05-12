variable "ami_name" {
  description = "Name tag for the security group"
  type        = string
  default     = "nginx-v1-ami"
}

data "aws_ami" "nginx-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }

}
