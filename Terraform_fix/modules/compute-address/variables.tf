variable "address_name" {
    type = string
}

variable "region" {
    type = string
}

variable "project" {
    type = string
}

variable "description" {
    type = string
}

variable "address_type" {
    type = string
    default = "EXTERNAL"
}

variable "network_tier" {
    type = string
    default = "PREMIUM"
}