output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the two public subnets"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "private_subnet_ids" {
  description = "IDs of the two private subnets"
  value       = [aws_subnet.private_a.id, aws_subnet.private_b.id]
}

output "web_public_ip" {
  description = "Public IP of the web server"
  value       = aws_instance.web.public_ip
}

output "web_instance_id" {
  description = "Instance ID of the web server"
  value       = aws_instance.web.id
}
