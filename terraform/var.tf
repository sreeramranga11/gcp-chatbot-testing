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
    autoclass = optional(object({
      enabled = bool
    }), "Enable Autoclass for automatic storage class management.")
    retention_policy = optional(object({
      is_locked        = bool
      retention_period = number # in seconds
    }), "Configure a retention policy to protect against data deletion.")
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
  description = "A list of Google Cloud Storage buckets to create and manage."

  validation {
    condition     = alltrue([for b in var.bucket : contains(["enforced", "inherited"], b.public_access_prevention)])
    error_message = "Invalid value for public_access_prevention. Allowed values are 'enforced' or 'inherited'."
  }
}
