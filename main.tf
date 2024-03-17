module "ec2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.instance_name
  instance_type          = var.instance_type
  key_name               = "develop_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.control-sg.id]
  subnet_id              = "subnet-03915205754a15ae4"
  ami                    = var.instance_ami
  user_data              = file("${path.module}/user-data.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = var.instance_name
  }
}
