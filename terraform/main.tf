resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo Hello, Terraform!"
  }
}

# Example: Filtering buckets by environment (for advanced use cases)
# locals {
#   env_buckets = [b for b in var.bucket if b.environment == var.target_environment]
# }
#
# module "env_bucket" {
#   source = "gitrepo.dev//terraform-google-cloud-storage"
#   for_each = { for b in local.env_buckets : b.name => b }
#   ...
# }

# Additional modules or resources can be scaffolded here for future expansion, such as bucket notifications, object management, etc.

resource "google_compute_network" "gke_vpc" {
  name                    = var.gke_network_name
  project                 = var.gke_project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.gke_subnetwork_name
  project       = var.gke_project_id
  ip_cidr_range = "10.10.0.0/24"
  region        = var.gke_location
  network       = google_compute_network.gke_vpc.id
}

resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  project  = var.gke_project_id
  location = var.gke_location

  # We can't create a cluster with no node pool defined, but we want to use
  # a separately managed node pool. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.gke_vpc.id
  subnetwork = google_compute_subnetwork.gke_subnet.id
}

resource "google_container_node_pool" "primary_nodes" {
  name       = var.gke_node_pool_name
  project    = var.gke_project_id
  location   = var.gke_location
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_node_count

  node_config {
    machine_type = var.gke_node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
