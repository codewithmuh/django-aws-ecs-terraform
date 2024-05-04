# S3 bucket resource
resource "aws_s3_bucket" "backend" {
  bucket = "codewithmuh-terraform-state-backend-image-99"
}

# Setting S3 bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# S3 bucket ACL
resource "aws_s3_bucket_acl" "backend" {
  depends_on = [aws_s3_bucket_ownership_controls.backend]
  bucket     = aws_s3_bucket.backend.id
  acl        = "private"
}

# Setting S3 bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# DynamoDB table resource
resource "aws_dynamodb_table" "backend" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"
}