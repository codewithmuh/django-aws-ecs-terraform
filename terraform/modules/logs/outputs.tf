output "log_group_arn" {
  value = aws_cloudwatch_log_group.log_group.arn
}

output "log_stream_name" {
  value = aws_cloudwatch_log_stream.log_stream.name
}