provider "google" {
  project = "${var.project}"
  access_token = "ya29.a0ARrdaM9qw_y5Xa0k2BS1by8g4wbznQOI69qXWy0JYqePQaBOLU48zr3ilBcdM4Cc6zLO4Qo3UAqaK8J_dLR56KBt14Mh6pP1wIUjGfwJFSO8UapOUVIHPe8zDSY1TLFWDSWpj8DuCmK7i53xkH1pSYHr_PMKqVH-kvNp"
}

resource "google_compute_network" "vpc_network" {
  name = "${var.name}-vpc"
}

resource "google_compute_subnetwork" "public_subnet" {
  name = "${var.name}-public-subnet"
  ip_cidr_range = var.public_subnet_cidr 
  region = var.region
  network = google_compute_network.vpc_network.name 
  private_ip_google_access = true
}

resource "google_container_cluster" "group3" {
  name                     = var.name
  project                  = var.project
  location                 = var.location
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  network                  = google_compute_network.vpc_network.id
  subnetwork               = google_compute_subnetwork.public_subnet.id 
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  private_cluster_config {
    enable_private_nodes = "true"
    enable_private_endpoint = "false"
    master_ipv4_cidr_block = var.master_private_ipv4_cidr
  }
}

resource "google_container_node_pool" "group3_pool" {
  name       = "${var.name}-node-pool"
  location   = var.location
  cluster    = google_container_cluster.group3.name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ] 
  }

  # Autoscaling config.
  autoscaling {
    min_node_count = var.gke_min_nodes_per_zone
    max_node_count = var.gke_max_nodes_per_zone
  }

  # Management Config
  management {
    auto_repair  = true
    auto_upgrade = false
  }

}
