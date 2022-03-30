variable "project" {}
variable "access_token" {}
variable "location" {}
variable "cluster_name" {}
variable "region" {}
variable "vpc_name" {}
variable "subnet_name" {}
variable "public_subnet_cidr" {}
variable "machine_type" {}
variable "master_private_ipv4_cidr" {}
variable "public_endpoint_ipv4" {}
variable "node_count" {}
variable "gke_min_nodes_per_zone" {}
variable "gke_max_nodes_per_zone" {}
variable "enable" {
	default = true
}
variable "disable" {
	default = false
}
