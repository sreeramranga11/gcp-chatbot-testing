module "bucket" {
  source                      = "git::https://gitrepo.dev//terraform-google-cloud-storage?ref=v1.0.3"
  for_each                    = { for eachbucket in var.bucket : eachbucket.name => eachbucket }
  name                        = each.key
  project_id                  = each.value.project_id
  location                    = each.value.location
  storage_class               = each.value.storage_class
  labels                      = merge(each.value.labels, { environment = each.value.environment })
  public_access_prevention    = each.value.public_access_prevention
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  versioning                  = each.value.versioning
  lifecycle_rules             = each.value.lifecycle_rules
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
