variable "region" {
  default = "us-central1"

}

variable "authorized_source_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "gke_master_ipv4_cidr_block" {
  type    = string
  default = "172.23.0.0/28"
}

variable "project" {
  type    = string
  default = "cronjobs-409106"
}

