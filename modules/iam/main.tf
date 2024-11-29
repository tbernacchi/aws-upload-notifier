# Lambda policy to access DynamoDB
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "lambda-dynamodb-policy"
  description = "IAM policy for Lambda to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Resource = "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.table_name}"
      }
    ]
  })
}

# Lambda role
resource "aws_iam_role" "lambda_role" {
  name = "lambda-dynamodb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
  role       = aws_iam_role.lambda_role.name
}

# DynamoDB
resource "aws_iam_policy" "dynamodb_admin_policy" {
  name        = "${var.policy_name_prefix}-dynamodb-admin"
  description = "Policy for DynamoDB table management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:UpdateTable",
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:TagResource",      
          "dynamodb:UntagResource",    
          "dynamodb:ListTagsOfResource",
          "dynamodb:DescribeContinuousBackups",  
          "dynamodb:DescribeTimeToLive",         
          "dynamodb:DescribeGlobalTableSettings", 
          "dynamodb:DescribeLimits",             
          "dynamodb:DescribeStream",             
          "dynamodb:ListStreams"                 
        ]
        Resource = [
          "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/Files",
          "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/Files/*"
        ]
      }
    ]
  })
}

# Step Functions policy
resource "aws_iam_policy" "step_functions_policy" {
  name        = "${var.policy_name_prefix}-step-functions"
  description = "Policy for Step Functions management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "states:CreateStateMachine",
          "states:DeleteStateMachine",
          "states:DescribeStateMachine",
          "states:ListStateMachines",
          "states:UpdateStateMachine",
          "states:TagResource",
          "states:UntagResource",
          "states:ListTagsForResource",
          "states:ValidateStateMachineDefinition",
          "states:ListStateMachineVersions",    
          "states:StartExecution",              
          "states:StopExecution",               
          "states:DescribeExecution",           
          "states:ListExecutions"               
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "user_step_functions" {
  user       = var.user_name
  policy_arn = aws_iam_policy.step_functions_policy.arn
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "user_dynamodb_admin" {
  user       = var.user_name
  policy_arn = aws_iam_policy.dynamodb_admin_policy.arn
}

