provider "google" {
  access_token = var.access_token
  project   = "airline1-sabre-wolverine"
}

resource "google_kms_key_ring" "keyring1" {
  name     = "keyring-example-1"
  location = "us-central1"
}

resource "google_kms_crypto_key" "nav-key1" {
  name            = "cryopt-key-nav1"
  key_ring        = google_kms_key_ring.keyring1.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_key_ring" "keyring2" {
  name     = "keyring-example-2"
  location = "us-east1"
}

resource "google_kms_crypto_key" "nav-key2" {
  name            = "cryopt-key-nav2"
  key_ring        = google_kms_key_ring.keyring2.id
  rotation_period = "7776000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "us-dev-abcd-fghi-secret1"
  

  labels = {
    env                  = "default"
    application_division = "pci",
    application_name     = "demo",
    application_role     = "app",
    au                   = "0223092",
    created              = "20211122",
    data_compliance      = "pci",
    data_confidentiality = "pub",
    data_type            = "test",
    environment          = "dev",
    gcp_region           = "us",
    owner                = "hybridenv",
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
        kms_key_name = google_kms_crypto_key.nav-key1.id
      }
      replicas {
        location = "us-east1"
        kms_key_name = google_kms_crypto_key.nav-key2.id
      }
    }
  }
}