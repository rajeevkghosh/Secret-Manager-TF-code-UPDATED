provider "google" {
  project = "airline1-sabre-wolverine"
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "wf_us_prod_sm_app01_sm01"


  labels = {
    application_division = "pci",
    application_name     = "demo",
    application_role     = "app",
    au                   = "0223092",
    created              = "20211122",
    environment          = "nonprod",
    gcp_region           = "us",
    owner                = "hybridenv",
  }

  replication {
    user_managed {
      replicas {
        location = "us-central1"
        customer_managed_encryption {
          kms_key_name = data.google_kms_crypto_key.nav-key13.id
        }
      }
      replicas {
        location = "us-east1"
        customer_managed_encryption {
          kms_key_name = data.google_kms_crypto_key.nav-key23.id
        }
      }
    }
  }
}

data "google_kms_key_ring" "keyring1" {
  name     = "wf-us-prod-kms-app01-res05"
  location = "us-central1"
}

data "google_kms_crypto_key" "nav-key13" {
  name            = "wf-us-prod-kms-app01-res0501"
  key_ring        = data.google_kms_key_ring.keyring1.id
}

data "google_kms_key_ring" "keyring2" {
  name     = "wf-us-prod-kms-app01-res06"
  location = "us-east1"
}

data "google_kms_crypto_key" "nav-key23" {
  name            = "wf-us-prod-kms-app01-res0601"
  key_ring        = data.google_kms_key_ring.keyring2.id
  
}

