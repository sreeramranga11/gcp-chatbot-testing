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

resource "google_storage_bucket" "bucket" {
  for_each = { for b in var.bucket : b.name => b }

  name                        = each.value.name
  project                     = each.value.project_id
  location                    = each.value.location
  storage_class               = each.value.storage_class
  public_access_prevention    = each.value.public_access_prevention
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  labels                      = each.value.labels

  versioning {
    enabled = each.value.versioning
  }

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rules != null ? each.value.lifecycle_rules : {}
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lifecycle_rule.value.action.storage_class
      }
      condition {
        age                        = lifecycle_rule.value.condition.age
        created_before             = lifecycle_rule.value.condition.created_before
        custom_time_before         = lifecycle_rule.value.condition.custom_time_before
        days_since_custom_time     = lifecycle_rule.value.condition.days_since_custom_time
        days_since_noncurrent_time = lifecycle_rule.value.condition.days_since_noncurrent_time
        matches_prefix             = lifecycle_rule.value.condition.matches_prefix
        matches_storage_class      = lifecycle_rule.value.condition.matches_storage_class
        matches_suffix             = lifecycle_rule.value.condition.matches_suffix
        noncurrent_time_before     = lifecycle_rule.value.condition.noncurrent_time_before
        num_newer_versions         = lifecycle_rule.value.condition.num_newer_versions
        with_state                 = lifecycle_rule.value.condition.with_state
      }
    }
  }

  dynamic "logging" {
    for_each = each.value.logging != null ? [each.value.logging] : []
    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = logging.value.log_object_prefix
    }
  }

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      default_kms_key_name = encryption.value.default_kms_key_name
    }
  }
}

locals {
  iam_members_flat = flatten([
    for bucket in var.bucket : [
      for binding in bucket.iam_bindings : {
        bucket_name = bucket.name
        role        = binding.role
        member      = binding.member
      } if bucket.iam_bindings != null
    ]
  ])
}

resource "google_storage_bucket_iam_member" "iam" {
  for_each = {
    for item in local.iam_members_flat : "${item.bucket_name}-${item.role}-${item.member}" => item
  }

  bucket = google_storage_bucket.bucket[each.value.bucket_name].name
  role   = each.value.role
  member = each.value.member
}
