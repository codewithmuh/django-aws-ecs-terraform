# provider.tf

# Specify the provider and access details
provider "aws" {
  profile = "default"
  region  = terraform.workspace
  default_tags {
    tags = {
      Environment = terraform.workspace
    }
  }
}