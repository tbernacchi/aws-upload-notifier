include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/iam"
}

inputs = {
  account_id = "913830480463"
  environment = "dev"
  aws_region = "sa-east-1"
  user_name  = "ambrosia"  # seu usuário IAM
  role_name_prefix = "dev-lambda"
  policy_name_prefix = "dev-dynamodb"
  table_name = "Files"
}
