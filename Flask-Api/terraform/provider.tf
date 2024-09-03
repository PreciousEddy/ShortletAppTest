provider "google" {
  credentials = var.GCP_SA_KEY
  project     = var.project_id
  region      = var.region
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

# Add the google_client_config data source
data "google_client_config" "default" {}
