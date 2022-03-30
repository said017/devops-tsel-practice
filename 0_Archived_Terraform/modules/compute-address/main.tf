resource "google_compute_address" "ip_address" {
  project = var.project
  region = var.region
  name = var.external_addr_name
  address_type = var.address_type
  network_tier = var.network_tier
}
