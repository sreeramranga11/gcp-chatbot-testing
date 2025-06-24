variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "main-vpc"
}

variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "main-gke-cluster"
}

variable "db_instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
  default     = "main-sql-instance"
}

variable "db_user" {
  description = "Database user name"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database user password"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
  default     = "main-storage-bucket"
} 