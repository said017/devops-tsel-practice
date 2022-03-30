resource "google_compute_firewall" "default" {
  name    = var.fw_name
  network = var.vpc_id
  allow {
    protocol = "icmp"
  }