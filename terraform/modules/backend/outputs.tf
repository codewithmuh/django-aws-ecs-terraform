output "s3_bucket_id" {
  value = aws_s3_bucket.backend.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.backend.name
}
