resource "aws_lambda_function" "file_processor" {
  filename         = "lambda.zip"  # seu código da lambda
  function_name    = "file-processor"
  role            = aws_iam_role.lambda_role.arn  # usa a role que criamos
  handler         = "index.handler"
  runtime         = "nodejs18.x"  # ou sua runtime preferida
}
