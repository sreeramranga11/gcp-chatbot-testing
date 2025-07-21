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

locals {
  # Find the production bucket configuration to use for CDN resources.
  # This assumes a single bucket is defined for the "prod" environment.
  prod_bucket_config = one([
    for b in var.bucket : b if b.environment == "prod"
  ])
}

data "google_project" "prod" {
  project_id = local.prod_bucket_config.project_id
}

resource "google_compute_backend_bucket" "livestream_backend" {
  name        = "${local.prod_bucket_config.name}-cdn-backend"
  project     = local.prod_bucket_config.project_id
  bucket_name = local.prod_bucket_config.name
  enable_cdn  = true
  description = "Backend bucket for high-volume livestreaming CDN"

  depends_on = [
    module.bucket
  ]
}

resource "google_storage_bucket_iam_member" "cdn_reader" {
  bucket = local.prod_bucket_config.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:service-${data.google_project.prod.number}@cloud-cdn-fill.iam.gserviceaccount.com"

  depends_on = [
    module.bucket
  ]
}
