# Simple Sandbox instance

This is a simple sandbox to start up a instance

## Deploy stack

Make sure thet you edit the terraform.tfvars

```
export AWS_DEFAULT_REGION=us-west-1
export AWS_PROFILE=geocompas
./deploy.sh create
```


## Delete stack

```
./deploy.sh delete
```