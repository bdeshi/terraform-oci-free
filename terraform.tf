terraform {
  required_version = "~> 1.8.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 5.42.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }
  }
  backend "remote" {}
}

provider "oci" {
  region              = var.oci_region
  config_file_profile = var.oci_profile
}
