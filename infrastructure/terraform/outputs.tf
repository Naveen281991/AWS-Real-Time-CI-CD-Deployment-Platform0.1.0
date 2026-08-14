output "vpc_id" {
  description = "ID of the CI/CD VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "ec2_instance_profile_name" {
  description = "IAM instance profile for the CodeDeploy EC2 instance"
  value       = aws_iam_instance_profile.ec2_codedeploy.name
}

output "ec2_role_arn" {
  description = "IAM role ARN for the CodeDeploy EC2 instance"
  value       = aws_iam_role.ec2_codedeploy.arn
}

output "codedeploy_service_role_arn" {
  description = "IAM service role ARN used by AWS CodeDeploy"
  value       = aws_iam_role.codedeploy.arn
}

output "artifact_bucket_name" {
  description = "S3 bucket used for CI/CD artifacts"
  value       = aws_s3_bucket.artifacts.id
}

output "artifact_bucket_arn" {
  description = "ARN of the CI/CD artifact bucket"
  value       = aws_s3_bucket.artifacts.arn
}

output "ec2_instance_id" {
  description = "ID of the CI/CD application EC2 instance"
  value       = aws_instance.application.id
}

output "ec2_public_ip" {
  description = "Public IP address of the CI/CD application EC2 instance"
  value       = aws_instance.application.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the CI/CD application EC2 instance"
  value       = aws_instance.application.public_dns
}


output "ecr_repository_name" {
  description = "ECR repository name for the application"
  value       = aws_ecr_repository.application.name
}

output "ecr_repository_url" {
  description = "ECR repository URL for the application"
  value       = aws_ecr_repository.application.repository_url
}

output "ecr_repository_arn" {
  description = "ECR repository ARN for the application"
  value       = aws_ecr_repository.application.arn
}


output "alb_dns_name" {
  description = "Public DNS name of the application load balancer"
  value       = aws_lb.application.dns_name
}