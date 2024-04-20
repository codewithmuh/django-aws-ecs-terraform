
# Set up CloudWatch group and log stream and retain logs for specified days
resource "aws_cloudwatch_log_group" "log_group" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days

  tags = {
    Name = var.log_group_name
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.log_group.name
}


