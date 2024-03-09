# module "realtime-tracking" {
#   source = "./modules/v2.7.2"
#   private_network = data.google_compute_subnetwork.internal-subnetwork.network
#   database_tier = "db-custom-4-15360"
#   db_instance_name = "realtime-tracking"
#   database_version = "POSTGRES_15"
#   disk_size = 100
#   ha_enabled = false
#   deletion_protection = true
#   user_labels = {
#     jira = "sre-10293"
#     billing-scope = "db-managed-postgres"
#   }
#   backup_configuration = [
#     {
#       enabled            = true
#       binary_log_enabled = false
#       start_time         = "17:00"
#       point_in_time_recovery_enabled = true
#     },
#   ]
#   read_replicas = [
#     {
#       read_replica_tier = "db-custom-4-15360"
#       ipv4_enabled = "false"
#       disk_size = 100
#     },
#   ]
#   database_flags = []
# }
