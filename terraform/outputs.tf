output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}

output "rds_port" {
  value = aws_db_instance.mysql.port
}
output "rds_username" {
  value = var.db_username
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/terraformkey ec2-user@${aws_instance.bastion.public_ip}"

}