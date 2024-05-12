ami_name = "nginx-v1-ami"

#---------------------------------Security Group ----------------------------------#

sg_name        = "nginx-sg"
sg_description = "Security group for nginx"
sg_vpc_id      = "vpc-08948b477ea890a62"

sg_inbound_ports = [
  { port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
  { port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
  { port = 443, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
]

sg_outbound_ports = [
  { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
]

sg_tags = {
  Name = "nginx1-sg"
}

#--------------------------------Launch Template ----------------------------------#

# Priavte Key

private_key_algorithm = "RSA"
private_key_rsa_bits  = 4096

# Launch Template

template_name        = "nginx-teamplate"
template_description = "Template for Dev-nginx"
instance_type        = "t2.micro"
instance_keypair     = "nginx1Key"
template_subnet_id   = "subnet-0bc16c9e01059b4ca"

#--------------------------Configure Auto Scaling group ---------------------------#

asg_name             = "nginx-asg"
asg_min_size         = 1
asg_max_size         = 3
asg_desired_capacity = 2

#---------------------------- Auto Scaling Policies -------------------------------#

asg_scaling_policy_name    = "target-tracking-policy"
asg_policy_type            = "TargetTrackingScaling"
asg_predefined_metric_type = "ASGAverageCPUUtilization"
asg_target_value           = 60.0

