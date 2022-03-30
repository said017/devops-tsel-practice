resource "google_compute_network" "vpc_net" {
  project = var.project
  name = var.vpc_name
  description = var.description
  auto_create_subnetworks = var.auto_create_subnet
  mtu = var.mtu
}
