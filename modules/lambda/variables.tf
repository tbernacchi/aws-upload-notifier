variable "function_name" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = number
}

variable "memory_size" {
  type = number
}

variable "environment_variables" {
  type = map(string)
}

variable "lambda_role_arn" {
  type = string
  description = "ARN of the IAM role for Lambda"
}

variable "s3_bucket_arn" {
  type = string
  description = "ARN of the S3 bucket that will trigger the Lambda"
}

variable "s3_bucket_id" {
  type = string
  description = "ID of the S3 bucket that will trigger the Lambda"
}
