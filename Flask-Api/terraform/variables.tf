variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "GCP_SA_KEY" {
  description = "Service account key"
  type        = string
  sensitive   = true
}

variable "instance_id" {
  description = "The ID of the instance to monitor"
  type        = string
}

variable "instance_zone" {
  description = "The zone of the instance to monitor"
  type        = string
}
