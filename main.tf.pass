provider "google" {
  project = "airline1-sabre-wolverine"
}

data "google_kms_key_ring" "keyring1" {
  name     = "us-dev-abcd-fghi-keyring1"
  location = "us-central1"
}

resource "google_kms_crypto_key" "nav-key12" {
  name            = "us-dev-abcd-fghi-cryptokey12"
  key_ring        = data.google_kms_key_ring.keyring1.id
  rotation_period = "7776000s"
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

  lifecycle {
    prevent_destroy = true
  }
}

data "google_kms_key_ring" "keyring2" {
  name     = "us-dev-abcd-fghi-keyring2"
  location = "us-east1"
}
resource "google_kms_crypto_key" "nav-key22" {
  name            = "us-dev-abcd-fghi-cryptokey22"
  key_ring        = data.google_kms_key_ring.keyring2.id
  rotation_period = "7776000s"
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
        customer_managed_encryption {
          kms_key_name = google_kms_crypto_key.nav-key12.id
        }
      }
      replicas {
        location = "us-east1"
        customer_managed_encryption {
          kms_key_name = google_kms_crypto_key.nav-key22.id
        }
      }
    }
  }
}