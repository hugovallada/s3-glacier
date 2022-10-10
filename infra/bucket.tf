resource "aws_s3_bucket" "glacier" {
  bucket = var.bucket_name

  lifecycle_rule {
    enabled = true
    prefix  = var.glacier_prefix

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 31
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    enabled = true
    prefix  = "expired/"

    transition {
      days          = 0
      storage_class = "DEEP_ARCHIVE"
    }
  }

  tags = {
    "Email" = "valladahugo@gmail.com"
  }

}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.glacier.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
