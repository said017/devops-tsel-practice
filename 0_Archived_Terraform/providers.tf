provider "google" {
  project = "${var.project}"
  region = "${var.region}"
  credentials = "${file("purwadhika-devops-kelas1-926eb4ae4e0f.json")}"
}