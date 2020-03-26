# Configure the OpenTelekomCloud Provider
# https://www.terraform.io/docs/providers/opentelekomcloud/
provider "opentelekomcloud" {
  insecure = true
  # cacert_file = # Welcome to Telekom certificate pain...
}

resource "opentelekomcloud_vpc_v1" "vpc_v1" {
  name = "vpc-4711"
  cidr = "192.168.32.0/19"
}

# Use S3 backend with OTC OBS bucket
terraform {
  backend "s3" {
    bucket = "a4tf-state"
    key = "otc/cx/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation = true
  }
}
