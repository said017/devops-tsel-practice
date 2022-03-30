resource "google_compute_instance" "instance" {
  name         = var.instance_name
  project      = var.project
  machine_type = var.machine_type
  zone         = var.zone
  allow_stopping_for_update = var.allow_tf_to_edit
  tags = var.tags
  boot_disk {
    initialize_params {
      image = var.image_instance
    }
  }
  network_interface {
    network = var.vpc_network_id
    subnetwork = var.subnet_id
    access_config {
    #  nat_ip = var.nat_ip
    }
  }
  metadata_startup_script = var.startup_script
}
