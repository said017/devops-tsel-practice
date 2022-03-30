resource "google_compute_firewall" "firewall" {
  project = var.project
  description = var.description
  name    = var.fw_name
  network = var.vpc_id
  source_ranges = var.source_ranges
  target_tags = var.target_tags
  allow {
    protocol = var.protocol
    ports = var.ports
  }
}