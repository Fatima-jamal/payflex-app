output "metabase_instance_id" {
  description = "ID of the Metabase EC2 instance"
  value       = aws_instance.metabase.id
}

output "metabase_sg_id" {
  description = "Security Group ID associated with the Metabase instance"
  value       = aws_security_group.metabase_sg.id
}
