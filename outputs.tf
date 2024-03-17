output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i develop_key.pem ubuntu@${module.ec2.public_ip} \n cat /home/ubuntu/.ssh/id_rsa.pub"
}
