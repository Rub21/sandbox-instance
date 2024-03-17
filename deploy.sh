#!/bin/bash
start_instance() {
    vpc_id=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId' --output text)
    subnet_id=$(aws ec2 describe-subnets --query 'Subnets[0].SubnetId' --output text)
    if [ ! -f develop_key.pem ]; then
      set -x
      aws ec2 create-key-pair --key-name develop_key --query 'KeyMaterial' --output text > develop_key.pem
      chmod 400 develop_key.pem
      set +x
    fi
    echo "vpc_id:" $vpc_id
    echo "subnet_id:" $subnet_id
    sed -i '' "s|subnet_id              =.*|subnet_id              = \"${subnet_id}\"|" main.tf

    ## Deploy 
    terraform init
    terraform plan
    terraform apply -auto-approve
}

delete_instance() {
    terraform destroy -auto-approve
    aws ec2 delete-key-pair --key-name develop_key
    chmod 777 *.pem && rm *.pem
}

## init
if [ "$1" = "create" ]; then
  start_instance

elif [ "$1" = "delete" ]; then
  delete_instance
else
  echo "Invalid argument. Please use 'create' or 'delete'."
fi