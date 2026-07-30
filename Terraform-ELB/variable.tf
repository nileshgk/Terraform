variable "YOUR_ACCESS_KEY" {
  description = "The AWS access key"
  type        = string
  default     = "YOUR_ACCESS_KEY"
}

variable "YOUR_SECRET_KEY" {
  description = "The AWS secret key"
  type        = string
  default     = "YOUR_SECRET_KEY"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "AMIS" {
  description = "A map of AWS region to AMI ID"
  type        = map(any)
  default = {
    "us-east-1"  = "ami-02b64aa047cb5edf5"
    "us-east-2"  = "ami-028ba4d4ccb4b7b72"
    "ap-south-1" = "ami-00d2dbb426772b03a"
  }
}

variable "PATH_TO_PUBLIC_KEY" {
  description = "Path to the public key file"
  type        = string
  default     = "keyPublic.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  description = "Path to the private key file"
  type        = string
  default     = "keyPrivate.pem"
}
