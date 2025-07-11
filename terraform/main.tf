module "bucket" {
  source                      = "gitrepo.dev//terraform-google-cloud-storage"
  version                     = "1.0.3"
  for_each                    = { for eachbucket in var.bucket : eachbucket.name => eachbucket }
  name                        = each.key
  project_id                  = each.value.project_id
  location                    = each.value.location
  storage_class               = each.value.storage_class
  labels                      = merge(each.value.labels, { environment = each.value.environment })
  public_access_prevention    = each.value.public_access_prevention
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  versioning                  = each.value.versioning
  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rules
    content {
      action = {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition = {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        custom_time_before         = lookup(lifecycle_rule.value.condition, "custom_time_before", null)
        days_since_custom_time     = lookup(lifecycle_rule.value.condition, "days_since_custom_time", null)
        days_since_noncurrent_time = lookup(lifecycle_rule.value.condition, "days_since_noncurrent_time", null)
        matches_prefix             = lookup(lifecycle_rule.value.condition, "matches_prefix", null)
        matches_storage_class      = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        matches_suffix             = lookup(lifecycle_rule.value.condition, "matches_suffix", null)
        noncurrent_time_before     = lookup(lifecycle_rule.value.condition, "noncurrent_time_before", null)
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", null)
      }
    }
  }
  # Optional future features for extensibility
  logging                     = try(each.value.logging, null)
  encryption                  = try(each.value.encryption, null)
  iam_bindings                = try(each.value.iam_bindings, null)
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
