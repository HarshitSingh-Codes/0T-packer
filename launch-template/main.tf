#---------------------------------Security Group ----------------------------------#

locals {
  sg_inbound_ports  = var.sg_inbound_ports
  sg_outbound_ports = var.sg_outbound_ports
}
resource "aws_security_group" "security_group" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.sg_vpc_id

  dynamic "ingress" {
    for_each = local.sg_inbound_ports
    content {
      from_port = ingress.value.port
      to_port   = ingress.value.port
      protocol  = ingress.value.protocol
      # Conditionally apply CIDR block or security group rule based on type
      cidr_blocks     = contains(keys(ingress.value), "cidr_blocks") ? [ingress.value.cidr_blocks] : null
      security_groups = contains(keys(ingress.value), "security_group_ids") ? [ingress.value.security_group_ids] : null
    }
  }
  dynamic "egress" {
    for_each = local.sg_outbound_ports
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }
  tags = var.sg_tags
}
#--------------------------------Launch Template ----------------------------------#

# Generate Private Key
resource "tls_private_key" "private_key" {
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

# Generate SSH Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.instance_keypair
  public_key = tls_private_key.private_key.public_key_openssh
}

# Download Private Key in PEM Format
resource "local_file" "private_key" {
  content  = tls_private_key.private_key.private_key_pem
  filename = "${var.instance_keypair}.pem"
}

resource "aws_launch_template" "launch_template" {
  name          = var.template_name
  description   = var.template_description
  image_id      = data.aws_ami.nginx-ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name
  network_interfaces {
    security_groups             = [aws_security_group.security_group.id]
    subnet_id                   = var.template_subnet_id
    associate_public_ip_address = true
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx-v2"
    }
  }
  # tags = {  
  #   Name                  = var.template_name
  # }
  # depends_on = [ aws_lb.Dev_Alb ]
}

#--------------------------Configure Auto Scaling group ---------------------------#

resource "aws_autoscaling_group" "asg" {
  name = var.asg_name
  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version
  }
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      instance_warmup        = 120
      max_healthy_percentage = 110
      skip_matching          = true
    }
    triggers = ["launch_template"]
  }

}

#---------------------------- Auto Scaling Policies -------------------------------#

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = var.asg_scaling_policy_name
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = var.asg_policy_type

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_predefined_metric_type
    }

    target_value = var.asg_target_value

  }
}

