variable "pod_name" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "ns_name" {
    type = string
} 

variable "image_name" {
    type = string
}

variable "image_ver" {
    type = string
}

variable "env_name_0" {
    type = string
}

variable "env_value_0" {
    type = string
}

variable "env_name_1" {
    type = string
}

variable "env_value_1" {
    type = string
}

variable "env_name_2" {
    type = string
}

variable "env_value_2" {
    type = string
}

variable "env_name_3" {
    type = string
}

variable "env_value_3" {
    type = string
}

variable "container_port" {
    type = number
}

variable "protocol" {
    type = string
}