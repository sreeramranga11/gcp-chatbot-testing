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

module "gcs_bucket" {
  source   = "gitrepo.dev//terraform-google-cloud-storage"
  for_each = { for b in var.bucket : b.name => b }

  name                        = each.value.name
  project_id                  = each.value.project_id
  location                    = each.value.location
  storage_class               = each.value.storage_class
  public_access_prevention    = each.value.public_access_prevention
  uniform_bucket_level_access = each.value.uniform_bucket_level_access
  versioning                  = each.value.versioning
  labels                      = each.value.labels
  lifecycle_rules             = each.value.lifecycle_rules
  logging                     = each.value.logging
  encryption                  = each.value.encryption
  iam_bindings                = each.value.iam_bindings
}
