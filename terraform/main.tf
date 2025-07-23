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

resource "google_pubsub_topic" "topics" {
  for_each = { for topic in var.pubsub_topics : topic.name => topic }

  project = each.value.project_id
  name    = each.value.name
  labels  = lookup(each.value, "labels", null)
}

resource "google_bigquery_dataset" "datasets" {
  for_each = { for dataset in var.bigquery_datasets : dataset.dataset_id => dataset }

  project       = each.value.project_id
  dataset_id    = each.value.dataset_id
  friendly_name = lookup(each.value, "friendly_name", null)
  description   = lookup(each.value, "description", null)
  location      = each.value.location
  labels        = lookup(each.value, "labels", null)

  dynamic "access" {
    for_each = lookup(each.value, "access", [])
    content {
      role           = access.value.role
      user_by_email  = lookup(access.value, "user_by_email", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      domain         = lookup(access.value, "domain", null)
      special_group  = lookup(access.value, "special_group", null)
    }
  }
}
