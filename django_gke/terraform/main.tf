# Prefix for all resources

provider "google" {
  project = "cronjobs-409106"
  region  = "us-central1"
}

locals {
  prefix = "prod"
}

