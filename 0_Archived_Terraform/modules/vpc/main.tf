resource "google_compute_network" "vpc_network" {
  name = var.gcp_vpc_name
  description = var.gcp_vpc_desc
  project = var.project
  auto_create_subnetworks = var.auto_create_subnet
  mtu = var.mtu
}

resource "google_compute_firewall" "firewall" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.id
  source_ranges = var.source_ranges
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }

}
