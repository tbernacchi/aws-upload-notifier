# State Machine Definition
resource "aws_sfn_state_machine" "file_processor" {
  name     = "file-processor"
  role_arn = aws_iam_role.step_function_role.arn

  definition = jsonencode({
    Comment = "A state machine that writes file info to DynamoDB"
    StartAt = "WriteToDynamoDB"
    States = {
      WriteToDynamoDB = {
        Type = "Task"
        Resource = "arn:aws:states:::dynamodb:putItem"
        Parameters = {
          TableName = var.dynamodb_table_name
          Item = {
            FileName = {
              "S.$" = "$.fileName"
            }
            UploadTime = {
              "S.$" = "$$.State.EnteredTime"
            }
          }
        }
        End = true
      }
    }
  })
}

# IAM Role for Step Function
resource "aws_iam_role" "step_function_role" {
  name = "step-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for Step Function to write to DynamoDB
resource "aws_iam_role_policy" "step_function_policy" {
  name = "step-function-policy"
  role = aws_iam_role.step_function_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem"
        ]
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}
