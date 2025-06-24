resource "google_service_account" "gke_sa" {
  account_id   = "gke-service-account"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke_sa_container_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_service_account" "sql_sa" {
  account_id   = "sql-service-account"
  display_name = "SQL Service Account"
}

resource "google_project_iam_member" "sql_sa_sql_admin" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.sql_sa.email}"
} 