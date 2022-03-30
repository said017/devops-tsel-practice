variable "project" {
    type = string
}

variable "region" {
    type = string
}

variable "external_addr_name" {
    type = string
}

variable "address_type" {
    type = string
    default = "EXTRENAL"
}

variable "network_tier" {
    type = string
    default = "PREMIUM"
}