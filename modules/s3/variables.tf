variable "region" {
  description = "The region to deploy the resources"
  type        = string
  default     = "sa-east-1"
}

variable "environment" {
  description = "The environment to deploy the resources"
  type        = string
  default     = ""
}

variable "project" {
  description = "The project name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "bucket_key_enabled" {
  type        = bool
  default     = false
  description = "Enable S3 bucket key (used to reduce KMS costs)"
}

variable "versioning" {
  type        = map(string)
  description = "Map containing versioning configuration."
  default     = {
    status = "Enabled"
    mfa_delete = "Disabled"
    enabled = true
  }
}
