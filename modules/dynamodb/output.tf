output "table_arn" {
  value = aws_dynamodb_table.files_table.arn
}

output "table_name" {
  value = aws_dynamodb_table.files_table.name
}
