output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_ids" { value = aws_subnet.public[*].id }
output "ec2_public_ip" { value = aws_instance.web.public_ip }
output "ec2_private_ip" { value = aws_instance.web.private_ip }
output "s3_bucket_name" { value = aws_s3_bucket.app.bucket }
output "security_group_id" { value = aws_security_group.web.id }
