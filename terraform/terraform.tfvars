# GCS BUCKET ATTRIBUTES

# Example: Multi-environment bucket definitions
bucket = [
  {
    name                        = "a-gcs-bucket-1234"
    project_id                  = "prj-gcp-dev-1111"
    environment                 = "a"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "a"
      team            = "data-eng"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 30
          matches_prefix = ["ingestion/backup/"]
        }
      }
    }
    logging = {
      log_bucket        = "a-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-dev-1111/locations/global/keyRings/dev-kr/cryptoKeys/dev-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:dev@example.com"
      }
    ]
  },
  {
    name                        = "b-gcs-bucket-1480"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "b"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "b"
      team            = "analytics"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 60
        }
      }
    }
    logging = {
      log_bucket        = "b-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-prod-1234/locations/global/keyRings/prod-kr/cryptoKeys/prod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.admin"
        member = "group:prod-admins@example.com"
      }
    ]
  },
  {
    name                        = "c-gcs-bucket-1481"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "c"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "c"
      team            = "analytics"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 60
        }
      }
    }
    logging = {
      log_bucket        = "c-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-prod-1234/locations/global/keyRings/prod-kr/cryptoKeys/prod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.admin"
        member = "group:prod-admins@example.com"
      }
    ]
  },
  {
    name                        = "d-gcs-bucket-1482"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "d"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "d"
      team            = "analytics"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 60
        }
      }
    }
    logging = {
      log_bucket        = "d-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-prod-1234/locations/global/keyRings/prod-kr/cryptoKeys/prod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.admin"
        member = "group:prod-admins@example.com"
      }
    ]
  },
  {
    name                        = "e-gcs-bucket-1483"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "e"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "e"
      team            = "analytics"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 60
        }
      }
    }
    logging = {
      log_bucket        = "e-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-prod-1234/locations/global/keyRings/prod-kr/cryptoKeys/prod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.admin"
        member = "group:prod-admins@example.com"
      }
    ]
  }
]
