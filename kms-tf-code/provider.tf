provider "google" {
  project      = var.project
  credentials = file("../kms.json")
}