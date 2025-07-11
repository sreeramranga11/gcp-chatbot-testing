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
    name                        = "france-gcs-bucket-9999"
    project_id                  = "prj-gcp-france-1111"
    environment                 = "france"
    location                    = "europe-west1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2024"
      environment     = "france"
      team            = "data-eng"
    }
    lifecycle_rules = {}
    logging = {
      log_bucket        = "france-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-france-1111/locations/global/keyRings/france-kr/cryptoKeys/france-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:france@example.com"
      }
    ]
  },
  {
    name                        = "germany-gcs-bucket-8888"
    project_id                  = "prj-gcp-germany-2222"
    environment                 = "germany"
    location                    = "europe-west3"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2024"
      environment     = "germany"
      team            = "data-eng"
    }
    lifecycle_rules = {}
    logging = {
      log_bucket        = "germany-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-germany-2222/locations/global/keyRings/germany-kr/cryptoKeys/germany-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:germany@example.com"
      }
    ]
  },
  {
    name                        = "japan-gcs-bucket-7777"
    project_id                  = "prj-gcp-japan-3333"
    environment                 = "japan"
    location                    = "asia-northeast1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2024"
      environment     = "japan"
      team            = "data-eng"
    }
    lifecycle_rules = {}
    logging = {
      log_bucket        = "japan-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-japan-3333/locations/global/keyRings/japan-kr/cryptoKeys/japan-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:japan@example.com"
      }
    ]
  }
]
