# GCS BUCKET ATTRIBUTES

# Example: Multi-environment bucket definitions
bucket = [
  {
    name                        = "dev-gcs-bucket-1234"
    project_id                  = "prj-gcp-dev-1111"
    environment                 = "dev"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "dev"
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
      log_bucket        = "dev-logging-bucket"
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
    name                        = "prod-gcs-bucket-1480"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "prod"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "prod"
      team            = "analytics"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type          = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 60
        }
      }
    }
    logging = {
      log_bucket        = "prod-logging-bucket"
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
    name                        = "dev-integration-files-5678"
    project_id                  = "prj-gcp-dev-1111"
    environment                 = "dev"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "12-01-2023"
      environment     = "dev"
      team            = "integration"
      ticket_id       = "CCS-84"
    }
    lifecycle_rules = {
      "delete_old_files" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 90
        }
      }
    }
    logging = {
      log_bucket        = "dev-logging-bucket"
      log_object_prefix = "logs/dev-integration-files-5678/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-dev-1111/locations/global/keyRings/dev-kr/cryptoKeys/dev-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectAdmin"
        member = "group:integration-devs@example.com"
      }
    ]
  },
  {
    name                        = "dev-integration-temp-9101"
    project_id                  = "prj-gcp-dev-1111"
    environment                 = "dev"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "12-01-2023"
      environment     = "dev"
      team            = "integration"
      ticket_id       = "CCS-84"
    }
    lifecycle_rules = {
      "delete_temp_files" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "dev-logging-bucket"
      log_object_prefix = "logs/dev-integration-temp-9101/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-dev-1111/locations/global/keyRings/dev-kr/cryptoKeys/dev-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectCreator"
        member = "serviceAccount:integration-sa@prj-gcp-dev-1111.iam.gserviceaccount.com"
      },
      {
        role   = "roles/storage.objectViewer"
        member = "group:integration-devs@example.com"
      }
    ]
  },
  {
    name                        = "prod-integration-files-2468"
    project_id                  = "prj-gcp-prod-1234"
    environment                 = "prod"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "12-01-2023"
      environment     = "prod"
      team            = "integration"
      ticket_id       = "CCS-84"
    }
    lifecycle_rules = {
      "transition_to_nearline" = {
        action = {
          type          = "SetStorageClass"
          storage_class = "NEARLINE"
        }
        condition = {
          age = 180
        }
      },
      "delete_old_versions" = {
        action = {
          type = "Delete"
        }
        condition = {
          num_newer_versions = 10
        }
      }
    }
    logging = {
      log_bucket        = "prod-logging-bucket"
      log_object_prefix = "logs/prod-integration-files-2468/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-prod-1234/locations/global/keyRings/prod-kr/cryptoKeys/prod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectAdmin"
        member = "group:integration-admins@example.com"
      }
    ]
  }
]
