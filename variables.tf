variable "aws_region" {
  type        = string
  description = "Region to deploy into"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Prefix used for resource names and tags"
  default     = "tf-vpc-demo"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# /24s carved out of the /16 with a gap between the public and private ranges,
# so more subnets can be added later without renumbering anything.
variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR for the public subnet in the first AZ"
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR for the public subnet in the second AZ"
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  type        = string
  description = "CIDR for the private subnet in the first AZ"
  default     = "10.0.11.0/24"
}

variable "private_subnet_b_cidr" {
  type        = string
  description = "CIDR for the private subnet in the second AZ"
  default     = "10.0.12.0/24"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"
}

# No default on purpose. Leaving SSH open to the world is the easiest way to
# turn a demo VPC into someone else's crypto miner.
variable "my_ip" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 198.51.100.24/32. Allowed to reach port 22"
}

variable "key_name" {
  type        = string
  description = "Name of an existing EC2 key pair. Leave unset if you do not need SSH"
  default     = null
}
