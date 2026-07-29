variable "region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Key pair name for the AWS RDS EC2 instance"
  type        = string
  default     = "AWS-EC2-Key"
}

variable "ami_id" {
  description = "AMI ID for the AWS RDS EC2 instance"
  type        = string
  default     = "ami-002192a70217ac181" # Example AMI ID, replace with a valid one 
}

variable "instance_type" {
  description = "Instance type for the AWS RDS EC2 instance"
  type        = string
  default     = "t3.small"
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "keys/AWS-EC2.pub"
}

variable "vpcname" {
  type        = string
  description = "The name of the VPC"
  default     = "AWS-VPC"
}

variable "vpc_environment" {
  type        = string
  description = "The environment for the VPC"
  default     = "Development"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "The instance tenancy attribute for the VPC"
  type        = string
  default     = "default"
}
variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "enable_ipv6" {
  description = "A boolean flag to enable/disable IPv6 support for the VPC"
  type        = bool
  default     = false
}

# AWS Subnet Variables
variable "cidr_pub_subnet1" {
  description = "The CIDR block for the first public subnet"
  type        = string
  default     = "10.0.0.0/24"
}
variable "cidr_pub_subnet2" {
  description = "The CIDR block for the second public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "cidr_pvt_subnet1" {
  description = "The CIDR block for the first private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "cidr_pvt_subnet2" {
  description = "The CIDR block for the second private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "availability_zone1" {
  description = "The availability zone for the first subnet"
  type        = string
  default     = "us-east-1a"
}
variable "availability_zone2" {
  description = "The availability zone for the second subnet"
  type        = string
  default     = "us-east-1b"
}

# MariaDB RDS Variables
variable "db_name" {
  description = "The name of the MariaDB database"
  type        = string
  default     = "mydatabase_MariaDB"
}
variable "db_username" {
  description = "The username for the MariaDB database"
  type        = string
  default     = "admin"
} 
variable "db_password" {
  description = "The password for the MariaDB database"
  type        = string
  default     = "admin123"
}
variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "mariadb"
}
variable "db_engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "10.5"
}
variable "db_parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "default.mariadb10.5"
}



