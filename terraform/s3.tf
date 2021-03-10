resource "aws_s3_bucket" "bucket-prueba" {
  provider = aws.region-master
  bucket   = var.s3-name

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 730
    }
  }
}
