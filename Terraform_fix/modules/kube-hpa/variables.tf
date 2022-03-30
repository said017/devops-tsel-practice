variable "hpa_name" {
    type = string
}

variable "ns_name" {
    type = string
}

variable "min_replicas" {
    type = number
}

variable "max_replicas" {
    type = number
}

variable "kind_name" {
    type = string
}

variable "dep_name" {
    type = string
}

variable "type_metric_1" {
    type = string
}

variable "resource_name_1" {
    type = string
}

variable "target_type_1" {
    type = string
}

variable "type_metric_2" {
    type = string
}

variable "resource_name_2" {
    type = string

}
variable "target_type_2" {
    type = string

}
variable "avg_utilization" {
    type = string
}