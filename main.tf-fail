provider "google" {
  project = "airline1-sabre-wolverine"
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "dev-abcd-fghi-secret2"


  labels = {
    env                  = "default"
   # application_division = "pci",
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
        location = "asia-south1"
      }
      replicas {
        location = "us-east1"
      }
    }
  }
}

data "google_kms_key_ring" "keyring1" {
  name     = "us-dev-abcd-fghi-keyring-sm1"
  location = "us-central1"
}

data "google_kms_crypto_key" "nav-key13" {
  name            = "us-dev-abcd-fghi-cryptokey-sm1"
  key_ring        = data.google_kms_key_ring.keyring1.id
}

data "google_kms_key_ring" "keyring2" {
  name     = "us-dev-abcd-fghi-keyring-sm2"
  location = "us-east1"
}

data "google_kms_crypto_key" "nav-key23" {
  name            = "us-dev-abcd-fghi-cryptokey-sm2"
  key_ring        = data.google_kms_key_ring.keyring2.id
  
}

