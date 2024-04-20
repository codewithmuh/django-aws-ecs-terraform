variable "bucket_name" {
  description = "Name of the S3 bucket"
  default     = "arun-terraform-state-backend-test"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  default     = "arun-terraform-state-lock"
}