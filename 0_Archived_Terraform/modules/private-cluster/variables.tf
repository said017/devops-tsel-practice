variable "cluster_name" {
	type = string
}

variable "project" {
	type = string
}

variable "location" {
	type = string
}

variable "remove_default_node_pool" {
	type = bool
	default = true
}

variable "initial_node_count" {
	type = number
}

variable "vpc_network_id" {
	
}

variable "subnet_id" {
	
}

variable "pod_cluster_ipv4_cidr" {
	
}

variable "oauth_scopes" {
	default = ["https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"]
}

variable "enable_private_nodes" {
	default = true
}

variable "enable_private_endpoint" {
	default = false
}

variable "master_ipv4_cidr_block" {

}
