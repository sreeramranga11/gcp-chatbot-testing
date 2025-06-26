  network  = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.subnet.id

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
  cluster    = google_container_cluster.primary.name
  location   = var.region

  node_count = 2 # Increased node count for concurrency

  node_config {
    machine_type = "e2-medium"
  member  = "serviceAccount:${google_service_account.sql_sa.email}"
}

resource "google_project_iam_member" "gke_sa_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

--- a/terraform/main.tf
+++ b/terraform/main.tf
@@ -97,11 +97,11 @@
