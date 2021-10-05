# Terraform module ecr

Terraform module creating AWS EFS repositories.

The complete list off created EFS resources is:

- EFS storage
- Security Group

## Description

The module creates EFS storage.

## Inputs

| Name                    | Description                                                           |   Type |              Default              | Required |
|:------------------------|:----------------------------------------------------------------------|:-------|:---------------------------------:|:--------:|
| env_name                | Env name (like `uat` or `prod`) used as a part of the repository name | string |                 -                 |   yes    |
| vpc_id                  | The ID of VPC                                                         | string |                 -                 |   yes    |
| vpc_cidr                | VPC CIDR block                                                        | string |              `false`              |   yes    |
| subnets_ids             | Subnets IDs for efs endpoints                                         |  list  |                 -                 |   yes    |
| lifecycle_policy        | A file system lifecycle policy object                                 | string |          "AFTER_30_DAYS"          |    no    |
| efs_protocol            | Security group ingress rule protocol                                  | string |               "tcp"               |    no    |
| efs_sg_allow_port_range | Security group ingress rule allowed port range                        |   map  |                2049               |    no    |
| efs_storage_name        | Name used for EFS tags and security group                             | string |                 -                 |   yes    |
| efs_encryption          | If true, the disk will be encrypted                                   |   map  | {enabled: "true", kms_key_id: ""} |    no    |

## Outputs

| Name              | Description       | Type   |
|:------------------|:------------------|:-------|
| efs_endpoint      | Endpoint of EFS   | string |
| efs_filesystem_id | Filesystem ID     | string |
| efs_sg_id         | Security Group ID | string |

## Usage example

```hcl
module "efs-storage-uat" {
  source          = "git@github.com:belighted/tf-module-efs.git?ref=0.1.0"
  env_name        = var.env_name

  vpc_id          = var.vpc_id
  vpc_cidr        = "10.21.0.0/16"
  subnets_ids     = [var.subnets_ids]

  lifecycle_policy = "AFTER_30_DAYS"
  
  efs_storage_name = "best-efs-storage-for-china-environments"

}
```

## Requirements

Terraform >= 0.12