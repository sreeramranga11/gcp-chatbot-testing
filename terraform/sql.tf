resource "google_sql_database_instance" "default" {
  name             = var.db_instance_name
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = "db-n1-standard-2"
    ip_configuration {
      ipv4_enabled    = true
      require_ssl     = false
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