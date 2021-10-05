output "efs_endpoint" {
  value = aws_efs_file_system.efs_storage.dns_name
}

output "efs_filesystem_id" {
  value = aws_efs_file_system.efs_storage.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}