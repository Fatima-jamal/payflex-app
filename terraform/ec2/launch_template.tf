variable "sg_id" {}
variable "public_subnet_ids" {}
variable "user_data_script" {}

resource "aws_launch_template" "app" {
  name_prefix   = "java-app-template-"
  image_id      = "ami-09f41acd0c74c597b"  # Amazon Linux 2 (us-west-1)
  instance_type = "t3.micro"
  key_name      = "FJMS"

  user_data = base64encode(file(var.user_data_script))

  vpc_security_group_ids = [var.sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "java-login-app-instance"
    }
  }
}

output "launch_template_id" {
  value = aws_launch_template.app.id
}
