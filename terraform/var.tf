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

variable "pubsub_topics" {
  description = "A list of Pub/Sub topics to create."
  type = list(object({
    name       = string
    project_id = string
    labels     = optional(map(string))
    iam_bindings = optional(list(object({
      role   = string
      member = string
    })))
  }))
  default = []
}

variable "bigquery_datasets" {
  description = "A list of BigQuery datasets to create."
  type = list(object({
    dataset_id                  = string
    project_id                  = string
    friendly_name               = optional(string)
    description                 = optional(string)
    location                    = string
    labels                      = optional(map(string))
    default_table_expiration_ms = optional(number)
    access = optional(list(object({
      role           = string
      user_by_email  = optional(string)
      group_by_email = optional(string)
      domain         = optional(string)
      special_group  = optional(string)
    })))
  }))
  default = []
}
