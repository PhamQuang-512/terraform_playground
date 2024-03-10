resource "google_container_cluster" "primary" {
  name     = "quangpham5-cluster-01"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.quangpham5.self_link
  subnetwork = google_compute_subnetwork.asia-east1.self_link
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "quangpham5-pool-1"
  location   = google_compute_subnetwork.asia-east1.self_link
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = false
    spot         = true
    machine_type = "e2-medium"
    disk_size_gb = 10
    disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    
    resource_labels = [
      "http-server",
      "https-server",
    ]

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
