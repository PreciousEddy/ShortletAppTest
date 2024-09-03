terraform {
  backend "gcs" {
    bucket = gs://assessment-state-bucket/
    prefix = "terraform/state"
  }
}
