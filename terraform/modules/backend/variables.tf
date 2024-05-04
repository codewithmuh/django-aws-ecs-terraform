variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "codewithmuh-terraform-state-backend-990"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "codewithmuh-db-terraform-state-lock"
}