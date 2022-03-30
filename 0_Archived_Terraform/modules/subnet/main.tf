resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  description   = var.subnet_desc
  project       = var.project
  region        = var.region
  network       = var.vpc_network_id
  ip_cidr_range = var.main_ip_cidr
  private_ip_google_access = var.private_ip_google_access
  secondary_ip_range {
    range_name    = var.secondary_range_name
    ip_cidr_range = var.secondary_ip_cidr
  }
}