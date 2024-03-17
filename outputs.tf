
output "master_public_ips" {
  description = "List of public IP addresses of master instances"
  value       = module.ec2_master.public_ip
}

output "worker_public_ips" {
  description = "List of public IP addresses of worker instances"
  value       = module.ec2_worker.public_ip
}
