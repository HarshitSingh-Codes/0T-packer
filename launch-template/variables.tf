
#---------------------------------Security Group ----------------------------------#

variable "sg_name" {
  description = "Name tag for the security group"
  type        = string
  default     = "nginx-sg"
}
variable "sg_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for nginx"
}
variable "sg_vpc_id" {
  description = "ID of the VPC for instances"
  type        = string
  default     = "vpc-0383f4dc3af051efa" # VPC ID
}
variable "sg_inbound_ports" {
  description = "List of inbound ports and protocols and cidr block"
  type        = list(map(any))
  default = [
    { port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
    { port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
  ]
}
variable "sg_outbound_ports" {
  description = "List of outbound ports and protocols and Cidr block "
  type        = list(map(any))
  default = [
    { port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", },
  ]
}
variable "sg_tags" {
  description = "Tags for Security Group"
  type        = map(string)
  default = {
    Name       = "nginx-sg"
  }
}

#--------------------------------Launch Template ----------------------------------#

# Key Generate

variable "private_key_algorithm" {
  description = "value"
  type        = string
  default     = "RSA"
}
variable "private_key_rsa_bits" {
  description = "value"
  type        = number
  default     = 4096
}

# Launch Template 

variable "template_name" {
  description = "Launch Template Name"
  type        = string
  default     = "nginx-template"
}
variable "template_description" {
  description = "Launch Template Description"
  type        = string
  default     = "Template for nginx"
}
variable "instance_type" {
  description = "Launch Template Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "instance_keypair" {
  description = "Launch Template Instance Type keypair name"
  type        = string
  default     = "nginxKey"
}
variable "template_subnet_id" {
  description = "Launch Template Subnet ID"
  type        = string
  default     = "subnet-04c0c823118f48202"

}


#--------------------------Configure Auto Scaling group ---------------------------#

variable "asg_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
  default     = "nginx-ASG"
}

variable "asg_min_size" {
  description = "The minimum number of instances in the ASG"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_desired_capacity" {
  description = "The desired number of instances in the ASG"
  type        = number
  default     = 1
}

#---------------------------- Auto Scaling Policies -------------------------------#

variable "asg_scaling_policy_name" {
  description = "The name of the scaling policy"
  type        = string
  default     = "target-tracking-policy"
}
variable "asg_policy_type" {
  description = "The type of adjustment to make"
  type        = string
  default     = "TargetTrackingScaling"
}
variable "asg_predefined_metric_type" {
  description = "The predefined metric type for tracking"
  type        = string
  default     = "ASGAverageCPUUtilization"
}
variable "asg_target_value" {
  description = "The target value for the predefined metric"
  type        = number
  default     = 50.0
}