resource "google_kms_crypto_key" "cryptokey2" {
  name = var.keyring_key_name2
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

  key_ring = google_kms_key_ring.keyring2.id
  skip_initial_version_creation = true
  import_only = true
  #depends_on = ["google_kms_key_ring_import_job.import-job"]
}

resource "google_kms_key_ring" "keyring2" {
  name     = var.keyring_name2
  location = var.keyring_location2
}
resource "google_kms_key_ring_import_job" "import-job2" {
  key_ring      = google_kms_key_ring.keyring2.id
  import_job_id = var.keyring_import_job2

  import_method    = "RSA_OAEP_3072_SHA1_AES_256"
  protection_level = "SOFTWARE"
}
resource "null_resource" "proto_descriptor2" {
  provisioner "local-exec" {
    command = <<EOT
    /usr/bin/openssl rand 32 > ${var.key_path2}/test.bin
    EOT
  }
}
resource "null_resource" "import2" {

  provisioner "local-exec" {
    command = <<EOT
    gcloud kms keys versions import \
      --import-job ${var.keyring_import_job2} \
      --location ${var.keyring_location2} \
      --keyring ${var.keyring_name2} \
      --key ${var.keyring_key_name2} \
      --algorithm google-symmetric-encryption \
      --target-key-file ${var.key_path2}/test.bin
    EOT
  }
}

