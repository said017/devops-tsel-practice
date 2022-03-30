variable "name_node_pool" {
	type = string
}

variable "location" {
	type = string
}

variable "cluster_id" {
	
}

variable "node_count" {
	type = number
}

variable "preemtible" {
	default = true
}

variable "machine_type" {
	default = "e2-medium"
}

variable "oauth_scopes" {
	default = ["https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"]
}

variable "auto_min_node" {
	type = number
}

variable "auto_max_node" {
	type = number
}

variable "auto_repair" {
	default = true
}

variable "auto_upgrade" {
	default = false
}