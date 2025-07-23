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

# Flatten IAM bindings for Pub/Sub topics and BigQuery datasets
locals {
  pubsub_iam_members = flatten([
    for topic in var.pubsub_topics : [
      for iam in topic.iam_bindings : {
        # Create a unique key for each member binding
        key        = "${topic.name}/${iam.role}/${iam.member}"
        topic_name = topic.name
        project_id = topic.project_id
        role       = iam.role
        member     = iam.member
      } if topic.iam_bindings != null
    ]
  ])
}

resource "google_pubsub_topic" "main" {
  for_each = { for topic in var.pubsub_topics : topic.name => topic }

  project = each.value.project_id
  name    = each.value.name
  labels  = lookup(each.value, "labels", null)
}

resource "google_pubsub_topic_iam_member" "main" {
  for_each = { for member in local.pubsub_iam_members : member.key => member }

  project = each.value.project_id
  topic   = each.value.topic_name
  role    = each.value.role
  member  = each.value.member

  depends_on = [google_pubsub_topic.main]
}

resource "google_bigquery_dataset" "main" {
  for_each = { for dataset in var.bigquery_datasets : dataset.dataset_id => dataset }

  project    = each.value.project_id
  dataset_id = each.value.dataset_id
  location   = each.value.location

  friendly_name               = lookup(each.value, "friendly_name", null)
  description                 = lookup(each.value, "description", null)
  labels                      = lookup(each.value, "labels", null)
  default_table_expiration_ms = lookup(each.value, "default_table_expiration_ms", null)

  dynamic "access" {
    for_each = each.value.access != null ? each.value.access : []
    content {
      role           = lookup(access.value, "role", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      domain         = lookup(access.value, "domain", null)
      special_group  = lookup(access.value, "special_group", null)
      dynamic "view" {
        for_each = lookup(access.value, "view", null) != null ? [access.value.view] : []
        content {
          project_id = view.value.project_id
          dataset_id = view.value.dataset_id
          table_id   = view.value.table_id
        }
      }
    }
  }
}
