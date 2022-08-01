resource "aws_kms_key" "self" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  provider                = aws
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "self" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "self" {
  bucket   = aws_s3_bucket.self.id
  provider = aws
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "self" {
  provider = aws
  bucket   = aws_s3_bucket.self.id
  acl      = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "self" {
  bucket   = aws_s3_bucket.self.bucket
  provider = aws

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.self.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "self" {
  bucket = aws_s3_bucket.self.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "self_logs" {
  bucket = "${var.bucket_name}_logs"
  tags   = merge({ "logs" : true }, var.tags)
}

resource "aws_s3_bucket_versioning" "self_logs" {
  bucket = aws_s3_bucket.self_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "self_logs" {
  bucket = aws_s3_bucket.self_logs.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "self_logs" {
  bucket = aws_s3_bucket.self_logs.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.self.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "self_logs" {
  bucket = aws_s3_bucket.self_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "self_logs" {
  bucket = aws_s3_bucket.self.id

  target_bucket = aws_s3_bucket.self_logs.id
  target_prefix = "log/"
}
