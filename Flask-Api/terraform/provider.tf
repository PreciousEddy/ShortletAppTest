provider "google" {
  credentials = file .env/ecstatic-device-434214-c6-2d196b017ad3.json
  project     = "<your-project-id>"
  region      = "us-central1"
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}
