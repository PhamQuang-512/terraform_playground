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


resource "google_compute_firewall" "master_node" {
  name      = "master-node"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["6443", "2379", "2380", "10250", "10259", "10257"]
  }

  target_tags   = ["master"]
  source_ranges = ["10.255.0.0/24"] # asia-east1 subnet range
}

resource "google_compute_firewall" "worker_node" {
  name      = "worker-node"
  network   = google_compute_network.quangpham5.self_link
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["10250", "30000-32767"]
  }

  target_tags   = ["worker"]
  source_ranges = ["10.255.0.0/24"] # asia-east1 subnet range
}
