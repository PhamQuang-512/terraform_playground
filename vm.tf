# Vault config
locals {
  vm_instances = [
    "vm-1",
    "vm-2",
    "vm-3",
  ]
}

resource "google_compute_instance" "vm_instances" {
  for_each     = toset(local.vm_instances)
  name         = join("-", ["quangpham5", each.value])
  machine_type = "e2-medium"
  tags         = ["vault", "http-server", "https-server", "master", "worker"]

  boot_disk {
    initialize_params {
      size  = "10"
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      type  = "pd-standard"
    }
  }
  network_interface {
    network    = google_compute_network.quangpham5.self_link
    subnetwork = google_compute_subnetwork.asia-east1.self_link
    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata_startup_script = file("./startup_script_vault.sh")
  scheduling {
    provisioning_model          = "SPOT"
    preemptible                 = true
    automatic_restart           = false
    instance_termination_action = "STOP"
  }
}
