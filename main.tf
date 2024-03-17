resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}
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
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = var.instance_name
  }
}
