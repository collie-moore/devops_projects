# Random Password
resource "random_password" "django-admin-user-password" {
  length           = 16
  special          = true
  override_special = "_%@"
}


resource "google_sql_database_instance" "mysql" {
  name             = "${local.prefix}-mysql"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {

    # Region and zonal availability
    availability_type = "REGIONAL"
    location_preference {
      zone = "${var.region}-a"
    }

    # Machine Type
    tier = "db-n1-standard-2"

    # Storage
    disk_size = 10

    # Connections
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.custom.id
    }

    # Backups
    backup_configuration {
      binary_log_enabled = true
      enabled            = true
      start_time         = "06:00"
    }
  }
  depends_on = [
    google_service_networking_connection.private-vpc-connection
  ]
}


resource "google_sql_database" "django" {
  name     = "django"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "django" {
  name     = "django"
  instance = google_sql_database_instance.mysql.name
  password = random_password.django-admin-user-password.result
}


resource "google_compute_global_address" "private-ip-peering" {
  name          = "google-managed-services-custom"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.custom.id
}

resource "google_service_networking_connection" "private-vpc-connection" {
  network = google_compute_network.custom.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private-ip-peering.name
  ]
}