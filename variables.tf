variable "env_name" {}

variable "vpc_id"   {}

variable "vpc_cidr" {
  description = "cidr for efs security group"
}

variable "subnets_ids" {
  type        = list
  description = "EFS: subnets id's for efs endpoints"
}

variable "lifecycle_policy" {
  default = "AFTER_30_DAYS"
}

variable "efs_protocol" {
  default = "tcp"
}

variable "efs_sg_allow_port_range" {
  description = "Allowed port ranges for incoming traffic for EFS service"
  default = [
    {
      from = "2049",
      to   = "2049"
    }
  ]
}

variable "efs_encryption" {
  type = map
  description = "The encryption needs to be true or false as well needs kms, all optional"
  default = {
    enabled = "true"
    kms_key_id = ""
  }
}

variable "efs_storage_name" {}