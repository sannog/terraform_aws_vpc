# terraform_aws_vpc
To create VPC, subnet, IGW, NAT-GW, SG and one Ubuntu EC2 instance.

A standalone Terraform config that builds a two-AZ AWS VPC from scratch. I put this
together because I had built the same network by hand in the console more times than
I want to admit, and I wanted a version I could review, diff, and tear down cleanly.

## What it creates

- VPC (10.0.0.0/16 by default) with DNS support enabled
- Two public and two private subnets across two AZs
- Internet gateway, plus a single NAT gateway with an Elastic IP
- Public and private route tables with the subnet associations
- Security group allowing SSH from one address and HTTP/HTTPS from anywhere
- One Ubuntu EC2 instance in a public subnet

## Prerequisites

- Terraform 1.5 or newer
- AWS CLI configured with credentials that can create VPC and EC2 resources
- An existing EC2 key pair in the target region if you want SSH

## Usage

```
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and set `my_ip` to your own address in CIDR form. Then:

```
terraform init
terraform plan
terraform apply
```

The public IP of the instance is in the outputs. When you are done:

```
terraform destroy
```

## Notes

There is one NAT gateway, not one per AZ. It sits in the first public subnet and both
private subnets route through it. That is the wrong call for production - losing that
AZ takes outbound traffic for everything private with it - but a second NAT gateway
roughly doubles the standing cost of the stack, and this is a reference build that
spends most of its life destroyed. For real HA, add a NAT gateway per AZ and give each
private subnet its own route table.

The AMI comes from a `most_recent` lookup against Canonical's account, so applying this
months apart can produce different images and replace the instance. That is fine here.
For anything long-lived I would pin the AMI ID and update it deliberately.

Everything lives in local state. Fine for a single-operator demo, not fine for a team -
that wants an S3 backend with locking.
