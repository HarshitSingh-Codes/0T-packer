data "aws_ami" "nginx-ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["nginx-v2-ami"]
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
