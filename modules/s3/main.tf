resource "aws_s3_bucket" "bucket_name" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.bucket_name.id
  # expected_bucket_owner = var.expected_bucket_owner
  mfa = try(var.versioning["mfa"], null)

  versioning_configuration {
    # Valid values: "Enabled" or "Suspended"
    status = try(
      var.versioning["enabled"] ? "Enabled" : "Suspended",
      tobool(var.versioning["status"]) ? "Enabled" : "Suspended",
      title(lower(var.versioning["status"]))
    )

    # Valid values: "Enabled" or "Disabled"
    mfa_delete = try(
      tobool(var.versioning["mfa_delete"]) ? "Enabled" : "Disabled",
      title(lower(var.versioning["mfa_delete"])),
      null
    )
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_key_enabled" {
  count = var.bucket_key_enabled ? 1 : 0
  bucket = aws_s3_bucket.bucket_name.id
  rule {
    bucket_key_enabled = var.bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}