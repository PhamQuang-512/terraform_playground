# Vault config
resource "google_compute_instance_template" "vault_template" {
  name_prefix = "quangpham5-vault"
  tags        = ["http-server", "https-server", "vault"]

  machine_type = "e2-medium"

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
    disk_size_gb = "10"
    disk_type    = "pd-balanced"
  }

  metadata_startup_script = file("./startup_script_vault.sh")

  network_interface {
    network    = google_compute_network.quangpham5.self_link
    subnetwork = google_compute_subnetwork.asia-east1.self_link
    access_config {
      network_tier = "PREMIUM"
    }
  }

  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false
  }

}

# resource "google_compute_health_check" "autohealing" {
#   name                = "autohealing-health-check"
#   check_interval_sec  = 5
#   timeout_sec         = 5
#   healthy_threshold   = 3
#   unhealthy_threshold = 10 # 50 seconds

#   tcp_health_check {
#     port = 8200
#   }
# }

# resource "google_compute_instance_group_manager" "vault_instance_group" {
#   name               = "quangpham5-vault-mig"
#   base_instance_name = "quangpham5-vault"

#   version {
#     instance_template = google_compute_instance_template.vault_template.self_link
#   }

#   target_size = 3

#   # auto_healing_policies {
#   #   health_check      = google_compute_health_check.autohealing.self_link
#   #   initial_delay_sec = 120
#   # }
# }

locals {
  vault_instances = [
    "vault-1",
    "vault-2",
    "vault-3",
  ]
}

resource "google_compute_instance_from_template" "vault_instances" {
  for_each                 = toset(local.vault_instances)
  name                     = join("-", ["quangpham5", each.value])
  source_instance_template = google_compute_instance_template.vault_template.self_link_unique
}
