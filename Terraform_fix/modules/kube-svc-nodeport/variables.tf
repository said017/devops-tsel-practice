variable "svc_name" {
    type = string
}

variable "ns_name" {
    type = string
}

variable "selector" {
    type = map(string)
}

variable "node_port" {
    type = number
}

variable "port" {
    type = number
}

variable "target_port" {
    type = number
}

variable "protocol" {
    type = string
}

variable "type" {
    type = string
}