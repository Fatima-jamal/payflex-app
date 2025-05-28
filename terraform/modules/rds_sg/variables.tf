variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_sg_ids" {
  description = "List of SGs allowed to access RDS"
  type        = list(string)
}
