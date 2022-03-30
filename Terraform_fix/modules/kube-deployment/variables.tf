variable "dep_name" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "replicas" {
    type = number
}

variable "ns_name" {
    type = string
}

variable "init_image_name" {
    type = string
}

variable "init_image_ver" {
    type = string
}

variable "init_cont_name" {
    type = string
}

variable "init_cont_comm" {
    type = list(string)
}

variable "image_name" {
    type = string
}

variable "cont_name" {
    type = string
}

variable "image_pull_policy" {
    type = string
    default = "Always"
}

variable "command" {
    type = list(string)
}

variable "cont_port" {
    type = number
}

variable "secret_name" {
    type = string
}