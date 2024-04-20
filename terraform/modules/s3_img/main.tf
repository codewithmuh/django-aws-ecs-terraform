resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
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