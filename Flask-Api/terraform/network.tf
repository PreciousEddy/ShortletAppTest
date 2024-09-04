# Define the VPC Network
resource "google_compute_network" "vpc_network" {
  name = "custom-vpc"
}

# Define the Subnetwork
resource "google_compute_subnetwork" "subnet" {
  name          = "custom-subnet"
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
  ip_cidr_range = "10.0.0.0/16"
}

# Define the Firewall Rules
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.0.0.0/16"]
}
