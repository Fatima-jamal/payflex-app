# variables.tf

variable "vpc_id" {
  description = "VPC where the EC2 instance will be launched"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be placed"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Metabase EC2"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "metabase_sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "metabase-sg"
}
