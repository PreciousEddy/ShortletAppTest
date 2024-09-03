resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-central1"

  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.subnet.id

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = "us-central1"
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_type    = "pd-standard

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
