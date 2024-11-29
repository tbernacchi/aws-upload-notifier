output "lambda_role_arn" {
  value       = aws_iam_role.lambda_role.arn
  description = "ARN of the Lambda IAM role"
}

output "dynamodb_policy_arn" {
  value       = aws_iam_policy.dynamodb_policy.arn
  description = "ARN of the DynamoDB policy"
}

output "step_functions_policy_arn" {
  value       = aws_iam_policy.stepfunctions_policy.arn
  description = "ARN of the Step Functions policy"
}