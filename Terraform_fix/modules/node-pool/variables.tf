variable "project" {
    type = string
}

variable "location" {
    type = string
}

variable "pool_name" {
    type = string
}

variable "cluster_id" {
    type = string
}

variable "initial_node_count" {
    type = string
}

variable "min_node_count" {
    type = number
}

variable "max_node_count" {
    type = number
}

variable "preemptible" {
    type = bool
    default = true
}

variable "machine_type" {
    type = string
}

variable "sa" {
    type = string
}

variable "oauth_scopes" {
    type = list(string)
    default = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
}