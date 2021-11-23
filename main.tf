provider "google" {
  access_token = var.access_token
}
resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "us-dev-abcd-fghi-secret1"
  project   = "airline1-sabre-wolverine"

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
          kms_key_name = "projects/airline1-sabre-wolverine/locations/us-east1/keyRings/savita-keyring1/cryptoKeys/savita-key11"
        }
      }
      replicas {
        location = "us-east1"
        customer_managed_encryption {
          kms_key_name = "projects/airline1-sabre-wolverine/locations/us-east1/keyRings/savita-keyring1/cryptoKeys/savita-key11"
        }
      }
    }
  }
}