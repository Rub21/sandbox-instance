module "ec2_master" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name   = "master-node"

  instance_type          = "t2.medium"
  key_name               = "k8s-gc"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.control_plane_sg.id]
  subnet_id              = "subnet-03915205754a15ae4"
  ami                    = "ami-05c969369880fa2c2"

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "master-node"
  }
}

module "ec2_worker" {
  source = "terraform-aws-modules/ec2-instance/aws"
  name   = "workers-node"

  create_spot_instance = true
  spot_price           = "0.004"
  spot_type            = "persistent"

  instance_type          = "t2.micro"
  key_name               = "k8s-gc"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.worker_nodes_sg.id]
  subnet_id              = "subnet-03915205754a15ae4"
  ami                    = "ami-05c969369880fa2c2"

  user_data = file("${path.module}/user-data.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "worker-node"
  }
}