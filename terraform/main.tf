# Scaffolding for Pub/Sub Topics
locals {
  pubsub_iam_members = flatten([
    for topic in var.pubsub_topics : [
      for binding in topic.iam_bindings : {
        topic_name = topic.name
        project_id = topic.project_id
        role       = binding.role
        member     = binding.member
      }
    ] if topic.iam_bindings != null
  ])
}

resource "google_pubsub_topic" "main" {
  for_each = { for topic in var.pubsub_topics : topic.name => topic }

  name    = each.value.name
  project = each.value.project_id
  labels  = each.value.labels
}

resource "google_pubsub_topic_iam_member" "binding" {
  for_each = { for item in local.pubsub_iam_members : "${item.topic_name}-${item.role}-${item.member}" => item }

  topic   = each.value.topic_name
  project = each.value.project_id
  role    = each.value.role
  member  = each.value.member

  depends_on = [google_pubsub_topic.main]
}

# Scaffolding for BigQuery Datasets
resource "google_bigquery_dataset" "main" {
  for_each = { for dataset in var.bigquery_datasets : "${dataset.project}.${dataset.dataset_id}" => dataset }

  dataset_id                  = each.value.dataset_id
  project                     = each.value.project
  location                    = each.value.location
  description                 = each.value.description
  delete_contents_on_destroy  = each.value.delete_contents_on_destroy
  labels                      = each.value.labels

  dynamic "access" {
    for_each = each.value.access != null ? each.value.access : []
    content {
      role                     = lookup(access.value, "role", null)
      user_by_email            = lookup(access.value, "user_by_email", null)
      group_by_email           = lookup(access.value, "group_by_email", null)
      service_account_by_email = lookup(access.value, "service_account_by_email", null)
      special_group            = lookup(access.value, "special_group", null)
      domain                   = lookup(access.value, "domain", null)

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
