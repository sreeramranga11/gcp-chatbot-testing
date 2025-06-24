output "network_name" {
  value = google_compute_network.vpc_network.name
}

output "gke_cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "sql_instance_connection_name" {
  value = google_sql_database_instance.default.connection_name
}

output "bucket_url" {
  value = google_storage_bucket.default.url
} 