resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "postgres-subnet-group"
  subnet_ids = [var.private_subnet_a_id, var.private_subnet_b_id]

  tags = {
    Name = "postgres-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "postgres-db"
  engine                 = "postgres"
  engine_version         = "11.22"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [var.postgres_sg_id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  storage_encrypted      = false

  tags = {
    Name = "postgres-db"
  }
}

