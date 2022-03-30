resource "google_container_cluster" "public_cluster" {
  project = var.project
  location = var.location
  name = var.cluster_name
  description = var.description
  network = var.vpc_net_id
  subnetwork = var.subnet_id
  remove_default_node_pool = var.remove_default_pool
  initial_node_count = var.initial_node_count
  ip_allocation_policy {
    cluster_secondary_range_name = var.pod_range_name
    # cluster_ipv4_cidr_block = var.pod_ipv4_cidr
    services_secondary_range_name = var.service_range_name
    # services_ipv4_cidr_block = var.service_ipv4_cidr
  }
  addons_config {
    horizontal_pod_autoscaling {
        disabled = var.hpa
    }
  }
}