terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.58.0"
    }
  }
}

provider "google" {
  project = var.project
  access_token = var.access_token
}

resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
}

resource "google_compute_subnetwork" "public_subnet" {
  name = var.subnet_name
  ip_cidr_range = var.public_subnet_cidr
  region = var.region
  network = google_compute_network.vpc_network.name
  private_ip_google_access = var.enable
}

resource "google_container_cluster" "group3" {
  name                     = var.cluster_name
  project                  = var.project
  location                 = var.location
  remove_default_node_pool = var.enable
  initial_node_count       = var.node_count
  network                  = google_compute_network.vpc_network.id
  subnetwork               = google_compute_subnetwork.public_subnet.id 
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  private_cluster_config {
    enable_private_nodes = "${var.enable}"
    enable_private_endpoint = "${var.disable}"
    master_ipv4_cidr_block = var.master_private_ipv4_cidr
    master_global_access_config {
      enabled = "${var.enable}"
    }
  }
}

resource "google_container_node_pool" "group3_pool" {
  name       = "${var.cluster_name}-node-pool"
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
    auto_repair  = var.enable
    auto_upgrade = var.disable
  }

}
