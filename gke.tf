# resource "google_container_cluster" "primary" {
#   name     = "quangpham5-cluster-01"
#   location = data.google_compute_subnetwork.internal-subnetwork

#   remove_default_node_pool = true
#   initial_node_count       = 1

#   network    = data.google_compute_network.quangpham5.self_link
#   subnetwork = data.google_compute_subnetwork.internal-subnetwork.self_link
# }

# resource "google_container_node_pool" "primary_preemptible_nodes" {
#   name       = "default-pool"
#   location   = data.google_compute_subnetwork.internal-subnetwork
#   cluster    = google_container_cluster.primary.name
#   node_count = 3

#   node_config {
#     preemptible  = false
#     spot         = true
#     machine_type = "e2-medium"
#     disk_size_gb = 10
#     disk_type    = "pd-standard"

#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }
