variable "project" {
    type = string
}

variable "zone" {
    type = string
}

variable "description" {
    type = string
}

variable "instance_name" {
    type = string
}

variable "machine_type" {
    type = string
    default = "e2-medium"
}

variable "tags" {
    type = list(string)
}

variable "allow_stopping_vm" {
    type = bool
}

variable "image" {
    type = string
}

variable "vpc_net_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "address_id" {
    type = string
}

variable "startup_script" {
    type = string
}