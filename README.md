# Simple Sandbox Cluster

This is a simple sandbox cluster using EC2 instances.

## Build ans deploy

```
export AWS_DEFAULT_REGION=us-west-1
export AWS_PROFILE=geocompas
./init.sh
terraform init
terraform plan
terraform apply

```
## Overwrite the output

```sh
ssh -i "k8s-gc.pem" ubuntu@54.177.118.210 "sudo echo '54.177.118.210 control-plane
3.101.109.80 worker1' >> /etc/hosts"

ssh -i "k8s-gc.pem" ubuntu@3.101.109.80 "sudo su && echo '54.177.118.210 control-plane
3.101.109.80 worker1' >> /etc/hosts"
```