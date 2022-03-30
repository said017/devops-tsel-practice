variable "ingress_name" {
    type = string
}

variable "ns_name" {
    type = string
}

variable "issuer_name" {
    type = string
}

variable "hosts" {
    type = list(string)
}

variable "secret_name" {
    type = string
}

variable "host_rule" {
    type = string
}

variable "path" {
    type = string
}

variable "svc_name" {
    type = string
}

variable "svc_port" {
    type = number
}
