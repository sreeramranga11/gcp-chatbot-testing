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

variable "target_environment" {
  type        = string
  description = "The target environment to filter buckets for (e.g., 'dev', 'prod')"
  default     = "dev"
}
