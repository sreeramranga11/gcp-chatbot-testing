# GCS BUCKET

variable "bucket" {
  type = list(object({
    name                        = string
    project_id                  = string
    environment                 = string # Added for multi-environment support
    location                    = string
    storage_class               = string
    public_access_prevention    = string
    uniform_bucket_level_access = bool
    versioning                  = bool
    labels                      = map(any)
    lifecycle_rules = optional(map(object({
      action = object({
        type          = string
        storage_class = optional(string)
      })
      condition = object({
        age                        = optional(number)
        created_before             = optional(string)
        custom_time_before         = optional(string)
        days_since_custom_time     = optional(number)
        days_since_noncurrent_time = optional(number)
        matches_prefix             = optional(list(string))
        matches_storage_class      = optional(list(string)) # STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE, DURABLE_REDUCED_AVAILABILITY
        matches_suffix             = optional(list(string))
        noncurrent_time_before     = optional(string)
        num_newer_versions         = optional(number)
        with_state                 = optional(string) # "LIVE", "ARCHIVED", "ANY"
      })
    })))
    # Optional future features for extensibility
    logging = optional(object({
      log_bucket        = string
      log_object_prefix = string
    }))
    encryption = optional(object({
      default_kms_key_name = string
    }))
    iam_bindings = optional(list(object({
      role   = string
      member = string
    })))
  }))
}

variable "gke_cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
}

variable "gke_project_id" {
  description = "The GCP project ID to host the GKE cluster."
  type        = string
}

variable "gke_location" {
  description = "The GCP location (region or zone) for the GKE cluster."
  type        = string
}

variable "gke_network_name" {
  description = "The name of the VPC network for the GKE cluster."
  type        = string
}

variable "gke_subnetwork_name" {
  description = "The name of the subnetwork for the GKE cluster."
  type        = string
}

variable "gke_node_pool_name" {
  description = "The name of the GKE node pool."
  type        = string
}

variable "gke_node_count" {
  description = "The number of nodes in the GKE node pool."
  type        = number
}

variable "gke_node_machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
}
