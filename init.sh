
vpc_id=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId' --output text)
if [ ! -f k8s-gc.pem ]; then
  aws ec2 create-key-pair --key-name k8s-gc --query 'KeyMaterial' --output text > k8s-gc.pem
  chmod 400 k8s-gc.pem
fi
sg_id=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=${vpc_id} --query 'SecurityGroups[*].GroupId' --output text)
echo "vpc_id:" $vpc_id
echo "sg_id:" $sg_id
echo "subnet_id:"
aws ec2 describe-subnets --query 'Subnets[*].SubnetId' --output text

