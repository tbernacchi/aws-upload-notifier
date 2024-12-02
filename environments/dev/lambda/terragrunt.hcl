include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules/lambda"
}

# Dependencies 
dependency "s3" {
  config_path = "../s3"
}

dependency "dynamodb" {
  config_path = "../dynamodb"
}

dependency "iam" {
  config_path = "../iam"
}

dependency "stepfunction" {
  config_path = "../stepfunction"
}

inputs = {
  function_name = "file-processor"
  handler      = "handler.lambda_handler"
  runtime      = "python3.9"
  timeout      = 30
  memory_size  = 128
  
  # Environment variables for the Lambda
  environment_variables = {
    DYNAMODB_TABLE = "Files"
    STEP_FUNCTION_ARN = dependency.stepfunction.outputs.state_machine_arn
  }
  
  lambda_role_arn = dependency.iam.outputs.lambda_role_arn
  s3_bucket_arn = dependency.s3.outputs.bucket_arn
  s3_bucket_id = dependency.s3.outputs.bucket_id
}
