provider "aws" {
  alias  = "replica"
  region = var.replica_region
}

resource "aws_iam_role" "replication" {
  name = "tf-iam-role-replication-12345"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  name = "tf-iam-role-policy-replication-12345"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl",
         "s3:GetObjectVersionTagging"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.source.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete",
        "s3:ReplicateTags"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.destination.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_kms_key" "destination" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  provider                = aws.replica
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "destination" {
  provider = aws.replica
  bucket   = var.bucket_name
}

resource "aws_s3_bucket_versioning" "destination" {
  bucket   = aws_s3_bucket.destination.id
  provider = aws.replica
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_acl" "destination" {
  provider = aws.replica
  bucket   = aws_s3_bucket.destination.id
  acl      = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "destination" {
  bucket   = aws_s3_bucket.destination.bucket
  provider = aws.replica

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.destination.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "destination" {
  bucket = aws_s3_bucket.destination.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "destination_logs" {
  provider = aws.replica
  bucket   = "${var.bucket_name}-logs"
}

resource "aws_s3_bucket_versioning" "destination_logs" {
  bucket   = aws_s3_bucket.destination_logs.id
  provider = aws.replica
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_acl" "destination_logs" {
  provider = aws.replica
  bucket   = aws_s3_bucket.destination_logs.id
  acl      = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "destination_logs" {
  bucket   = aws_s3_bucket.destination_logs.bucket
  provider = aws.replica

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.destination.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "destination_logs" {
  bucket = aws_s3_bucket.destination_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "destination" {
  bucket = aws_s3_bucket.destination.id

  target_bucket = aws_s3_bucket.destination_logs.id
  target_prefix = "log/"
}

resource "aws_kms_key" "source" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  provider                = aws
  enable_key_rotation     = true
}

resource "aws_s3_bucket" "source" {
  provider = aws
  bucket   = var.bucket_name
}

resource "aws_s3_bucket_versioning" "source" {
  bucket   = aws_s3_bucket.source.id
  provider = aws
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "source" {
  provider = aws
  bucket   = aws_s3_bucket.source.id
  acl      = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "source" {
  bucket   = aws_s3_bucket.source.bucket
  provider = aws

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.source.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "source" {
  bucket = aws_s3_bucket.source.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "source_logs" {
  provider = aws
  bucket   = "${var.bucket_name}-logs"
}

resource "aws_s3_bucket_versioning" "source_logs" {
  bucket   = aws_s3_bucket.source_logs.id
  provider = aws
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "source_logs" {
  provider = aws
  bucket   = aws_s3_bucket.source_logs.id
  acl      = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "source_logs" {
  bucket   = aws_s3_bucket.source_logs.bucket
  provider = aws

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.source.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "source_logs" {
  bucket = aws_s3_bucket.source_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "source" {
  bucket = aws_s3_bucket.source.id

  target_bucket = aws_s3_bucket.source_logs.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_replication_configuration" "source" {
  provider = aws
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source.id

  rule {
    id = "basic"

    filter {}

    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.destination.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket_replication_configuration" "logs" {
  provider = aws
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.source_logs]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.source_logs.id

  rule {
    id = "basic"

    filter {}

    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.destination_logs.arn
      storage_class = "STANDARD"
    }
  }
}
