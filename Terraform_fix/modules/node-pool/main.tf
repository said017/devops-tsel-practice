resource "google_container_node_pool" "node_pool" {
  project = var.project
  name       = var.pool_name
  location   = var.location
  cluster    = var.cluster_id
  initial_node_count = var.initial_node_count
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
    service_account = var.sa
    oauth_scopes = var.oauth_scopes
  }
}