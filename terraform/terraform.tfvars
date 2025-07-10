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
    name                        = "qa-gcs-bucket-1500"
    project_id                  = "prj-gcp-qa-1112"
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
      team            = "qa-eng"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 14
        }
      }
    }
    logging = {
      log_bucket        = "qa-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-qa-1112/locations/global/keyRings/qa-kr/cryptoKeys/qa-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:qa@example.com"
      }
    ]
  },
  {
    name                        = "staging-gcs-bucket-1501"
    project_id                  = "prj-gcp-staging-1113"
    environment                 = "staging"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "staging"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "staging-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-staging-1113/locations/global/keyRings/staging-kr/cryptoKeys/staging-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:staging@example.com"
      }
    ]
  },
  {
    name                        = "integration-gcs-bucket-1502"
    project_id                  = "prj-gcp-integration-1114"
    environment                 = "integration"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "integration"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "integration-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-integration-1114/locations/global/keyRings/integration-kr/cryptoKeys/integration-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:integration@example.com"
      }
    ]
  },
  {
    name                        = "preprod-gcs-bucket-1503"
    project_id                  = "prj-gcp-preprod-1115"
    environment                 = "preprod"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "preprod"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 30
        }
      }
    }
    logging = {
      log_bucket        = "preprod-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-preprod-1115/locations/global/keyRings/preprod-kr/cryptoKeys/preprod-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:preprod@example.com"
      }
    ]
  },
  {
    name                        = "perf-gcs-bucket-1504"
    project_id                  = "prj-gcp-perf-1116"
    environment                 = "perf"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "perf"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "perf-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-perf-1116/locations/global/keyRings/perf-kr/cryptoKeys/perf-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:perf@example.com"
      }
    ]
  },
  {
    name                        = "sandbox-gcs-bucket-1505"
    project_id                  = "prj-gcp-sandbox-1117"
    environment                 = "sandbox"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "sandbox"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "sandbox-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-sandbox-1117/locations/global/keyRings/sandbox-kr/cryptoKeys/sandbox-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:sandbox@example.com"
      }
    ]
  },
  {
    name                        = "demo-gcs-bucket-1506"
    project_id                  = "prj-gcp-demo-1118"
    environment                 = "demo"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "demo"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "demo-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-demo-1118/locations/global/keyRings/demo-kr/cryptoKeys/demo-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:demo@example.com"
      }
    ]
  },
  {
    name                        = "training-gcs-bucket-1507"
    project_id                  = "prj-gcp-training-1119"
    environment                 = "training"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "training"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "training-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-training-1119/locations/global/keyRings/training-kr/cryptoKeys/training-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:training@example.com"
      }
    ]
  },
  {
    name                        = "acceptance-gcs-bucket-1508"
    project_id                  = "prj-gcp-acceptance-1120"
    environment                 = "acceptance"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "acceptance"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 14
        }
      }
    }
    logging = {
      log_bucket        = "acceptance-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-acceptance-1120/locations/global/keyRings/acceptance-kr/cryptoKeys/acceptance-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:acceptance@example.com"
      }
    ]
  },
  {
    name                        = "loadtest-gcs-bucket-1509"
    project_id                  = "prj-gcp-loadtest-1121"
    environment                 = "loadtest"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "loadtest"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "loadtest-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-loadtest-1121/locations/global/keyRings/loadtest-kr/cryptoKeys/loadtest-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:loadtest@example.com"
      }
    ]
  },
  {
    name                        = "regression-gcs-bucket-1510"
    project_id                  = "prj-gcp-regression-1122"
    environment                 = "regression"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "regression"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "regression-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-regression-1122/locations/global/keyRings/regression-kr/cryptoKeys/regression-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:regression@example.com"
      }
    ]
  },
  {
    name                        = "canary-gcs-bucket-1511"
    project_id                  = "prj-gcp-canary-1123"
    environment                 = "canary"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "canary"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "canary-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-canary-1123/locations/global/keyRings/canary-kr/cryptoKeys/canary-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:canary@example.com"
      }
    ]
  },
  {
    name                        = "security-gcs-bucket-1512"
    project_id                  = "prj-gcp-security-1124"
    environment                 = "security"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "security"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "security-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-security-1124/locations/global/keyRings/security-kr/cryptoKeys/security-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:security@example.com"
      }
    ]
  },
  {
    name                        = "performance-gcs-bucket-1513"
    project_id                  = "prj-gcp-performance-1125"
    environment                 = "performance"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "performance"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 7
        }
      }
    }
    logging = {
      log_bucket        = "performance-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-performance-1125/locations/global/keyRings/performance-kr/cryptoKeys/performance-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:performance@example.com"
      }
    ]
  },
  {
    name                        = "compliance-gcs-bucket-1514"
    project_id                  = "prj-gcp-compliance-1126"
    environment                 = "compliance"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = false
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "compliance"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 90
        }
      }
    }
    logging = {
      log_bucket        = "compliance-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-compliance-1126/locations/global/keyRings/compliance-kr/cryptoKeys/compliance-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:compliance@example.com"
      }
    ]
  },
  {
    name                        = "disasterrecovery-gcs-bucket-1515"
    project_id                  = "prj-gcp-dr-1127"
    environment                 = "disasterrecovery"
    location                    = "us-central1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    versioning                  = true
    labels = {
      created_by      = "terraform"
      created_on_date = "11-08-2023"
      environment     = "disasterrecovery"
      team            = "devops"
    }
    lifecycle_rules = {
      "rule1" = {
        action = {
          type = "Delete"
        }
        condition = {
          age = 180
        }
      }
    }
    logging = {
      log_bucket        = "dr-logging-bucket"
      log_object_prefix = "logs/"
    }
    encryption = {
      default_kms_key_name = "projects/prj-gcp-dr-1127/locations/global/keyRings/dr-kr/cryptoKeys/dr-key"
    }
    iam_bindings = [
      {
        role   = "roles/storage.objectViewer"
        member = "user:dr@example.com"
      }
    ]
  }
]
