output "api_service_ip" {
  description = "The external IP address of the API service"
  value       = google_compute_address.api_address.address
}
