# find terragrunt.hcl on live folder(root level)
include "root" {
  path = find_in_parent_folders()
}

# module
terraform {
  source = "../../../modules/dynamodb"
}

# variables
inputs = {
  table_name  = "Files"
  environment = "dev"
  project     = "my-project"
 
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}