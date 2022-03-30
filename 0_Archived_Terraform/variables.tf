variable "project" {
	default = "purwadhika-devops-kelas1"
}

variable "location" {
	default = "australia-southeast2-a"
}

variable "name" {
	default = "devops-telkomsel-3"
}

variable "region" {
        default = "australia-southeast2"
}

variable "initial_node_count" {
	default = 2
}

variable "machine_type" {
	default = "e2-medium"
}

variable "node_count" {
  default = 2
}

variable "gke_min_nodes_per_zone" {
  default = 2
}

variable "gke_max_nodes_per_zone" {
  default = 4
}

variable "public_subnet_cidr" {
  default = "20.20.20.0/24"
}

variable "master_private_ipv4_cidr" {
  default = "172.16.0.0/28"
}
