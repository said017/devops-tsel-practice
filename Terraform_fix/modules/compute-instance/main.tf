resource "google_compute_instance" "instance" {
  project = var.project
  zone = var.zone
  description = var.description
  name         = var.instance_name
  machine_type = var.machine_type
  tags = var.tags
  allow_stopping_for_update = var.allow_stopping_vm
  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  network_interface {
    network = var.vpc_net_id
    subnetwork = var.subnet_id
    access_config {
      nat_ip = var.address_id
    }
  }
  metadata_startup_script = var.startup_script
}