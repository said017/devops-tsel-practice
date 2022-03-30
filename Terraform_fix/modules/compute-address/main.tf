resource "google_compute_address" "static" {
  project = var.project
  region = var.region
  name = var.address_name
  description = var.description
  address_type = var.address_type
  network_tier = var.network_tier
}