terraform {
  backend "gcs" {
    bucket = assessment-state-bucket
    prefix = "terraform/state"
  }
}
