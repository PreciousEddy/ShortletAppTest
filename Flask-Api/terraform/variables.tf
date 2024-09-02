variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "GCP_SA_KEY_PATH" {
  description = "Service account key"
  type        = string
  sensitive   = true
}