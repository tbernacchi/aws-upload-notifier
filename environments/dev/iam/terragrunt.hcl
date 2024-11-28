include "root" {
  path = find_in_parent_folders("terragrunt.hcl") # Find the root terragrunt.hcl file
}

terraform {
  source = "../../../modules/iam"
}

inputs = {
  user_name  = "ambrosia"  # Your IAM user name
  role_name_prefix = "dev-lambda"
  policy_name_prefix = "dev-dynamodb"
  table_name = "Files"
}
