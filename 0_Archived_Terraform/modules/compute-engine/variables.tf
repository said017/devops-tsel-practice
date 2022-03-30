variable "instance_name" {
    type = string
}

variable "project" {
    type = string
}

variable "machine_type" {
    type = string
}

variable "zone" {
    type = string
}

variable "allow_tf_to_edit" {
    type = bool
    default = true
}

variable "image_instance" {
    type = string
    default = "ubuntu-minimal-2004-focal-v20210720"
}

variable "tags" {
    default = []
}

variable "vpc_network_id" {
    type = string
}

variable "subnet_id" {
    type = string
}

#variable "nat_ip" {
#    type = string
#}

variable "startup_script" {
    type = string
}