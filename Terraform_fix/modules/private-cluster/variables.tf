variable "project" {
    type = string
}

variable "location" {
    type = string
}

variable "cluster_name" {
    type = string
}

variable "description" {
    type = string
}

variable "vpc_net_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "remove_default_pool" {
    type = bool
    default = true
}

variable "initial_node_count" {
    type = number
    default = 1
}

variable "pod_range_name" {
}

# variable "pod_ipv4_cidr" {
#     type = string
# }

variable "service_range_name" {
}

# variable "service_ipv4_cidr" {
# }

variable "enable_private_nodes" {
    type = bool
    default = true
}

variable "enable_private_endpoint" {
    type = bool
    default = false
}

variable "master_ipv4_cidr_block" {
    type = string
}

variable "hpa" {
    type = bool
    default = false
}