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

locals {
  # Flattening IAM bindings for Pub/Sub topics to be used in for_each
  pubsub_iam_bindings = flatten([
    for topic in var.pubsub_topics : [
      for binding in topic.iam_bindings : {
        topic_name = topic.name
        role       = binding.role
        member     = binding.member
      } if topic.iam_bindings != null
    ]
  ])
}

resource "google_pubsub_topic" "topic" {
  for_each = { for topic in var.pubsub_topics : topic.name => topic }

  name    = each.value.name
  project = each.value.project_id
  labels  = each.value.labels
}

resource "google_pubsub_topic_iam_member" "member" {
  for_each = { for b in local.pubsub_iam_bindings : "${b.topic_name}-${b.role}-${b.member}" => b }

  project = google_pubsub_topic.topic[each.value.topic_name].project
  topic   = google_pubsub_topic.topic[each.value.topic_name].name
  role    = each.value.role
  member  = each.value.member
}

resource "google_bigquery_dataset" "dataset" {
  for_each = { for dataset in var.bigquery_datasets : dataset.dataset_id => dataset }

  dataset_id                  = each.value.dataset_id
  project                     = each.value.project_id
  friendly_name               = each.value.friendly_name
  description                 = each.value.description
  location                    = each.value.location
  labels                      = each.value.labels
  default_table_expiration_ms = each.value.default_table_expiration_ms

  dynamic "access" {
    for_each = each.value.access != null ? each.value.access : []
    content {
      role           = lookup(access.value, "role", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      domain         = lookup(access.value, "domain", null)
      special_group  = lookup(access.value, "special_group", null)
    }
  }
}
