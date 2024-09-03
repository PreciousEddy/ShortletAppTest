resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_address" "api_address" {
  name   = "api-address"
  region = "us-central1"

  lifecycle {
    prevent_destroy = true
  }
}

variable "project_id" {
  description = "The ID of the project in which to create the resources."
  type        = string
}
