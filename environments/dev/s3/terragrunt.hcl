# find terragrunt.hcl on live folder(root level)
include "root" {
  path = find_in_parent_folders()
}

# module
terraform {
  source = "../../../modules/s3"
}

# variables
inputs = {
  bucket_name = "ambrosia-files-${formatdate("YYYYMMDD", timestamp())}-913830480463"
  environment = "dev"
  project     = "my-project"
 
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
