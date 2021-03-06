variable "aws_region" {
  type                     = string
}

variable "aws_profile" {
  type                     = string
}

variable "vpc_cidr" {
  type                     = string
}

variable "pubnet1_cidr" {
  type                     = string
}

variable "pubnet1_instance_ip" {
  type                     = string
}

variable "guacnet_cidr" {
  type                     = string
}

variable "guacnet_guacd" {
  type                     = string
}

variable "guacnet_guacdb" {
  type                     = string
}

variable "guacnet_guacamole" {
  type                     = string
}

variable "mgmt_cidr" {
  type                     = string
  description              = "Subnet CIDR allowed to access WebUI and SSH, e.g. 172.16.10.0/30"
}

variable "instance_type" {
  type                     = string
  description              = "The type of EC2 instance to deploy"
}

variable "instance_key" {
  type                     = string
  description              = "A public key for SSH access to instance(s)"
}

variable "instance_vol_size" {
  type                     = number
  description              = "The volume size of the instances' root block device"
}

variable "kms_manager" {
  type                     = string
  description              = "An IAM user for management of KMS key"
}

variable "bucket_name" {
  type                     = string
  description              = "A unique bucket name to store playbooks and output of SSM"
}

variable "ec2_name_prefix" {
  type                     = string
  description              = "A friendly name prefix for the AMI and EC2 instances, e.g. 'cw' or 'dev'"
}

variable "vendor_ami_account_number" {
  type                     = string
  description              = "The account number of the vendor supplying the base AMI"
}

variable "vendor_ami_name_string" {
  type                     = string
  description              = "The search string for the name of the AMI from the AMI Vendor"
}

provider "aws" {
  region                   = var.aws_region
  profile                  = var.aws_profile
}

# region azs
data "aws_availability_zones" "cw-azs" {
  state                    = "available"
}

# account id
data "aws_caller_identity" "cw-aws-account" {
}

# kms cmk manager - granted read access to KMS CMKs
data "aws_iam_user" "cw-kmsmanager" {
  user_name               = var.kms_manager
}
