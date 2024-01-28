terraform {
  backend "gcs" {
    bucket = "cronjobs-409106-bucket"
    prefix = "prod"
  }
}