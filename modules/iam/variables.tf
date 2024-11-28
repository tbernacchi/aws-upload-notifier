variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "user_name" {
  type        = string
  description = "IAM user name"
}

variable "table_name" {
  type        = string
  description = "DynamoDB table name"
  default     = "Files"
}