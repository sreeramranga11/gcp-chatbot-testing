resource "google_sql_database_instance" "default" {
  name             = var.db_instance_name
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-custom-1-3840"
    disk_size = 10
    disk_type = "SSD"
    ip_configuration {
      ipv4_enabled    = true
      require_ssl     = false
    }
  }
}

  }
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_sql_database" "default" {
  name     = "app_db"
  instance = google_sql_database_instance.default.name
} 