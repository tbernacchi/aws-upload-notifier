# common configuration
remote_state {
  backend = "local"
  config = {
    path = "${get_terragrunt_dir()}/terraform.tfstate"
  }
}

# global variables
inputs = {
  region      = "sa-east-1"
}

# Provider
generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
provider "aws" {
  region     = "sa-east-1"
  profile    = "default"
}

terraform {
  backend "local" {}
}
EOF
}
