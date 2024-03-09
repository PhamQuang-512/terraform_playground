# Vault config
resource "google_compute_instance_template" "vault_template" {
  name_prefix = "quangpham5-vault"
  tags        = ["http-server", "https-server", "gke-access"]

  machine_type = "e2-medium"

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
    disk_size_gb = "10"
    disk_type    = "pd-balanced"
  }

  metadata_startup_script = file("./startup_script_vault.sh")

  network_interface {
    network    = google_compute_network.quangpham5.id
    subnetwork = google_compute_subnetwork.asia-east1.id
  }

  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false
  }

}
