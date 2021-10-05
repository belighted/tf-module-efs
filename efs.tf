resource "aws_efs_file_system" "efs_storage" {
  creation_token = "${var.env_name}-${var.efs_storage_name}"
  encrypted = lookup(var.efs_encryption, "enabled")
  kms_key_id = lookup(var.efs_encryption, "kms_key_id")

  lifecycle_policy {
    transition_to_ia = var.lifecycle_policy
  }

  tags = {
      "Name" = format("%s", "efs-${var.env_name}-${var.efs_storage_name}"),
      "Env" = format("%s", var.env_name)
  }
}

resource "aws_efs_mount_target" "efs_target" {
  count             = length(var.subnets_ids)
  file_system_id    = aws_efs_file_system.efs_storage.id
  subnet_id         = element(var.subnets_ids, count.index)
  security_groups   = [aws_security_group.efs_sg.id]
}

resource "aws_security_group" "efs_sg" {
  description = "Managed by Terraform for EFS"
  vpc_id      = var.vpc_id
  name        = "efs-${var.env_name}-${var.efs_storage_name}-sg"
  dynamic "ingress" {
    for_each = var.efs_sg_allow_port_range
    content {
      protocol = var.efs_protocol
      from_port = ingress.value["from"]
      to_port = ingress.value["to"]
      cidr_blocks = [var.vpc_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = {
      "Name" = format("%s", "efs-${var.env_name}-${var.efs_storage_name}-sg"),
      "Env" = format("%s", var.env_name)
  }
}
