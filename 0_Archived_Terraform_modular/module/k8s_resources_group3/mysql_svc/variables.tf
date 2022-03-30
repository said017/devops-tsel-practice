variable "svc_name" {
  description = "Name of the mysql service"
  type        = string
  default     = "mysql-service"
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "selector" {
  description = "My SQL pod selector"
  type        = string
  default     = "mysql"
}