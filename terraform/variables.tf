variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "project_name" {
  type    = string
  default = "project3-rds"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}


variable "my_ip_cidr" {
  description = "Your workstation public IP in CIDR form (e.g. 203.0.113.5/32)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "private_subnet_1_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "private_subnet_2_cidr" {
  type    = string
  default = "10.10.3.0/24"
}

variable "instance_type_bastion" {
  type    = string
  default = "t3.micro"
}

variable "bastion_ami" {
  description = "AMI for bastion (Amazon Linux 2 recommended)"
  type        = string
  default     = "ami-0fa3fe0fa7920f68e"
}

variable "key_name" {
  description = "EC2 key pair name (already imported into AWS)"
  type        = string
  default     = "ssh/terraformkey.pub"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_name" {
  type    = string
  default = "app_db"
}


variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "ssh/terraformkey.pub"
}