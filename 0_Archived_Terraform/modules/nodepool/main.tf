
resource "google_container_node_pool" "node_pool" {
  name       = var.name_node_pool
  location   = var.location
  cluster    = var.cluster_id
  node_count = var.node_count
  node_config {
    preemptible  = var.preemtible
    machine_type = var.machine_type
    oauth_scopes = var.oauth_scopes
  }

  # Autoscaling config.
  autoscaling {
    min_node_count = var.auto_min_node
    max_node_count = var.auto_max_node
  }
  # Management Config
  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

}
