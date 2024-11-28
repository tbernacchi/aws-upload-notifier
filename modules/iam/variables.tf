variable "user_name" {
  type        = string
  description = "IAM user name"
}

variable "table_name" {
  type        = string
  description = "DynamoDB table name"
  default     = "Files"
}
