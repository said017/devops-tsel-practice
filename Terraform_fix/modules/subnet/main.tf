resource "google_compute_subnetwork" "subnet" {
  project       = var.project
  region        = var.region
  name          = var.subnet_name
  description   = var.description
  network       = var.vpc_net_id
  ip_cidr_range = var.main_ip_cidr
  private_ip_google_access = var.private_ip_google_access
  secondary_ip_range {
    range_name    = var.pod_range_name
    ip_cidr_range = var.pod_ip_cidr
  }
  secondary_ip_range {
    range_name    = var.service_range_name
    ip_cidr_range = var.service_ip_cidr    
  }
}