# Define the Static IP Address
resource "google_compute_address" "api_address" {
  name   = "api-address"
  region = var.region

  lifecycle {
    prevent_destroy = true
  }

}





