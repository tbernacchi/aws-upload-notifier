variable "user_name" {
  type        = string
  description = "IAM user name"
}

variable "table_name" {
  type        = string
  description = "DynamoDB table name"
  default     = "Files"
}

variable "policy_name_prefix" {
  type        = string
  description = "Prefix for policy names"
  default     = "dev"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}
