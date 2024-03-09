# resource "google_service_account" "vault_kms_service_account" {
#   account_id   = "vault-gcpkms"
#   display_name = "Vault KMS for auto-unseal"
# }

# resource "google_compute_instance" "vault" {
#   name         = "quangpham5-vault-test"
#   machine_type = "e2-small"
#   zone         = var.gcloud-zone

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2004-lts"
#     }
#   }

#   network_interface {
#     network = data.google_compute_network.quangpham5
#     subnetwork = data.google_compute_subnetwork.internal-subnetwork

#     access_config {
#       # Ephemeral IP
#     }
#   }

#   allow_stopping_for_update = true

#   # Service account with Cloud KMS roles for the Compute Instance
#   service_account {
#     email  = google_service_account.vault_kms_service_account.email
#     scopes = ["cloud-platform", "compute-rw", "userinfo-email", "storage-ro"]
#   }

#   metadata_startup_script = "${file("./startup_script_vault.sh")}"

# }

# # Create a KMS key ring
# resource "google_kms_key_ring" "key_ring" {
#   project  = "${var.gcloud-project}"
#   name     = "${var.key_ring}"
#   location = "${var.keyring_location}"
# }

# # Create a crypto key for the key ring
# resource "google_kms_crypto_key" "crypto_key" {
#   name            = "${var.crypto_key}"
#   key_ring        = "${google_kms_key_ring.key_ring.self_link}"
#   rotation_period = "100000s"
# }

# # Add the service account to the Keyring
# resource "google_kms_key_ring_iam_binding" "vault_iam_kms_binding" {
#   key_ring_id = "${google_kms_key_ring.key_ring.id}"
#   # key_ring_id = "${var.gcloud-project}/${var.keyring_location}/${var.key_ring}"
#   role = "roles/owner"

#   members = [
#     "serviceAccount:${google_service_account.vault_kms_service_account.email}",
#   ]
# }