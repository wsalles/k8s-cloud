data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "remote" {
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "lock" {
  name           = "tflock-${aws_s3_bucket.remote.bucket}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remote.arn
}
