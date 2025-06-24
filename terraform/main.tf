module "network" {
  source = "./network.tf"
}

module "gke" {
  source = "./gke.tf"
}

module "sql" {
  source = "./sql.tf"
}

module "storage" {
  source = "./storage.tf"
}

module "iam" {
  source = "./iam.tf"
} 