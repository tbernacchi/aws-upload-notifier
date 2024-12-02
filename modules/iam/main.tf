# -----------------------------
# Lambda Role and Policies
# -----------------------------
resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"

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

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.policy_name_prefix}-lambda"
  description = "Policy for Lambda management"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:DeleteFunction",
          "lambda:GetFunction",
          "lambda:InvokeFunction",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:ListVersionsByFunction",
          "lambda:PublishVersion",
          "lambda:GetFunctionConfiguration",
          "lambda:ListTags",
          "lambda:TagResource",
          "lambda:UntagResource",
          "lambda:GetFunctionCodeSigningConfig",
          "lambda:DeleteFunctionCodeSigningConfig",
          "lambda:PutFunctionCodeSigningConfig",
          "lambda:AddPermission",
          "lambda:GetPolicy",
          "lambda:RemovePermission"
        ]
        Resource = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:file-processor"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "${var.policy_name_prefix}-s3"
  description = "Policy for S3 notifications"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketNotification",
          "s3:PutBucketNotification"
        ]
        Resource = "arn:aws:s3:::${var.bucket_name}"
      }
    ]
  })
}


# -----------------------------
# DynamoDB Policies
# -----------------------------
resource "aws_iam_policy" "dynamodb_policy" {
  name        = "${var.policy_name_prefix}-dynamodb"
  description = "Policy for DynamoDB access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:CreateTable",
          "dynamodb:DeleteTable",
          "dynamodb:DescribeTable",
          "dynamodb:ListTables",
          "dynamodb:UpdateTable"
        ]
        Resource = "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/*"
      }
    ]
  })
}

# -----------------------------
# Step Functions Policies
# -----------------------------
resource "aws_iam_policy" "stepfunctions_policy" {
  name        = "${var.policy_name_prefix}-stepfunctions"
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
          "states:StartExecution"
        ]
        Resource = "arn:aws:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:*"
      }
    ]
  })
}

# -----------------------------
# Policy Attachments
# -----------------------------
resource "aws_iam_user_policy_attachment" "lambda_attachment" {
  user       = var.user_name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_user_policy_attachment" "dynamodb_attachment" {
  user       = var.user_name
  policy_arn = aws_iam_policy.dynamodb_policy.arn
}

resource "aws_iam_user_policy_attachment" "stepfunctions_attachment" {
  user       = var.user_name
  policy_arn = aws_iam_policy.stepfunctions_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  user       = var.user_name
  policy_arn = aws_iam_policy.s3_policy.arn
}
