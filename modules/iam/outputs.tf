output "lambda_role_arn" {
  value       = aws_iam_role.lambda_role.arn
  description = "ARN of the Lambda IAM role"
}

output "dynamodb_policy_arn" {
  value       = aws_iam_policy.dynamodb_admin_policy.arn
  description = "ARN of the DynamoDB policy"
}

output "step_functions_policy_arn" {
  value       = aws_iam_policy.step_functions_policy.arn
  description = "ARN of the Step Functions policy"
}
