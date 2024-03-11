resource "google_compute_firewall" "access_http" {
  name      = "access-http"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "access_https" {
  name      = "access-https"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["https-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "access_ssh" {
  name      = "access-ssh"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "vault_internal_access" {
  name      = "vault-internal-access"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8200", "8201"]
  }

  target_tags = ["vault"]
  source_tags = ["vault"]
}

resource "google_compute_firewall" "gke_access_vault" {
  name      = "gke-access-vault"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8200"]
  }

  target_tags   = ["vault"]
  source_ranges = ["172.16.0.0/22"] # pod range
}
