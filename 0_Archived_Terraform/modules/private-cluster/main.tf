resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  project                  = var.project
  location                 = var.location
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  network                  = var.vpc_network_id
  subnetwork               = var.subnet_id 
  #The IP address range of the Kubernetes pods
#  cluster_ipv4_cidr        = var.pod_cluster_ipv4_cidr
  node_config {
    oauth_scopes = var.oauth_scopes
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.pod_cluster_ipv4_cidr
#    services_ipv4_cidr_block = "10.0.0.0/20"
  }
  private_cluster_config {
    enable_private_nodes = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }
}