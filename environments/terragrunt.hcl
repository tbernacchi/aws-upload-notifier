# Root terragrunt.hcl

# Locals block para variáveis compartilhadas
locals {
  account_id = get_aws_account_id()
  project_name = "ambrosia"
  environment = "dev"
  bucket_name = "${local.project_name}-files-${local.environment}-${local.account_id}"
}

remote_state {
  backend = "local"
  config = {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }
}

# Provider
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  profile    = "default"
}

#backend
terraform {
  backend "local" {}
}

# Data sources availables for all modules
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
EOF
}

# global variables
inputs = {
  environment = "dev"
  bucket_name = local.bucket_name
}
