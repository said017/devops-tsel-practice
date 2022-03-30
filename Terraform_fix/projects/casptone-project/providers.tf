terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.79.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.11.3"
    }
        helm = {
      source  = "hashicorp/helm"
      version = "= 2.1.0"
    }
  }

  backend "gcs" {
    bucket  = "tf-state-group3"
    prefix  = "terraform/state"
    credentials = "purwadhika-devops-kelas1-926eb4ae4e0f.json"
  }

  # required_version = "=1.0.4"
}


provider "google" {
  project = "${var.project}"
  region = "${var.region}"
  credentials = "${file("purwadhika-devops-kelas1-926eb4ae4e0f.json")}"
}

provider "time" {
  # Configuration options
}


data "google_client_config" "google_config" {
  depends_on = [module.private_cluster]
}

data "google_container_cluster" "our_cluster" {
  depends_on = [module.private_cluster]
  name = module.private_cluster.cluster_name
  location = var.zones
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.our_cluster.endpoint}"
  token = data.google_client_config.google_config.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.our_cluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.our_cluster.endpoint}"
    token = data.google_client_config.google_config.access_token
    # cluster_ca_certificate = data.google_container_cluster.our_cluster.master_auth[0].cluster_ca_certificate
    cluster_ca_certificate = base64decode(
    data.google_container_cluster.our_cluster.master_auth[0].cluster_ca_certificate,
  )
  }
}

provider "kubectl" {
  host  = "https://${data.google_container_cluster.our_cluster.endpoint}"
  token = data.google_client_config.google_config.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.our_cluster.master_auth[0].cluster_ca_certificate,
  )
  load_config_file = false
}

