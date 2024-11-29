include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules/stepfunction"
}

dependency "dynamodb" {
  config_path = "../dynamodb"
}

inputs = {
  dynamodb_table_name = "Files"
  dynamodb_table_arn  = dependency.dynamodb.outputs.table_arn
}
