resource "google_compute_network" "quangpham5" {
  name                    = "quangpham5"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "asia-east1" {
  name                     = "asia-east1"
  region                   = "asia-east1"
  network                  = google_compute_network.quangpham5.id
  private_ip_google_access = "true"

  ip_cidr_range = "10.255.0.0/24"

  secondary_ip_range = [
    {
      range_name    = "gke-pods"
      ip_cidr_range = "172.16.0.0/22"
    },
    {
      range_name    = "gke-services"
      ip_cidr_range = "255.128.0.0/22"
    }
  ]
}
