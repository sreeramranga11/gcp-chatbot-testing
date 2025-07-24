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

resource "google_pubsub_topic" "topic" {
  for_each = { for topic in var.pubsub_topics : topic.name => topic }

  project = each.value.project_id
  name    = each.value.name
  labels  = each.value.labels
}

resource "google_bigquery_dataset" "dataset" {
  for_each = { for dataset in var.bigquery_datasets : dataset.dataset_id => dataset }

  project       = each.value.project_id
  dataset_id    = each.value.dataset_id
  friendly_name = each.value.friendly_name
  description   = each.value.description
  location      = each.value.location
  labels        = each.value.labels
}
