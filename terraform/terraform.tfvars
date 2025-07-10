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
          type = "SetStorageClass"
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
    name                        = "qa-gcs-bucket-1234"
    project_id                  = "prj-gcp-qa-1111"
    environment                 = "qa"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "qa"
      team            = "qa-team"
    }
    lifecycle_rules = {}
    logging = {
      log_bucket        = "qa-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-qa-1111/locations/global/keyRings/qa-kr/cryptoKeys/qa-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:qa@example.com"
      }
    ]
  },
  {
    name                        = "test-gcs-bucket-1480"
    project_id                  = "prj-gcp-test-1234"
    environment                 = "test"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "test"
      team            = "test-team"
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
      log_bucket        = "test-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-test-1234/locations/global/keyRings/test-kr/cryptoKeys/test-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.admin"
        member = "group:test-admins@example.com"
      }
    ]
  },
    {
    name                        = "monkey-gcs-bucket-1234"
    project_id                  = "prj-gcp-monkey-1111"
    environment                 = "monkey"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "monkey"
      team            = "monkey-team"
    }
    lifecycle_rules = {}
    logging = {
      log_bucket        = "monkey-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-monkey-1111/locations/global/keyRings/monkey-kr/cryptoKeys/monkey-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:monkey@example.com"
      }
    ]
  }
]
