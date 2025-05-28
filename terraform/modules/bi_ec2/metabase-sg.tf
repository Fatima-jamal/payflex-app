
resource "aws_security_group" "metabase_sg" {
  name        = "metabase-sg"
  description = "Allow HTTP access to Metabase"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP access"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "metabase-sg"
  }
}
