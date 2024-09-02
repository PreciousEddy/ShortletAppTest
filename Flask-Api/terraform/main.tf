# Define the VPC Network
resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}

# Define the Subnetwork

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

# Define the Static IP Address
resource "google_compute_address" "api_address" {
  name   = "api-address"
  region = var.region
}




