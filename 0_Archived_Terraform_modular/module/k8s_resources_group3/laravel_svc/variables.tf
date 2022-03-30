variable "svc_name" {
  description = "Name of the laravel service"
  type        = string
  default     = "laravel-service"
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "node_port_number" {
  description = "NodePort number"
  type        = number
  default     = 30081
}

variable "svc_type" {
  description = "service type"
  type        = string
  default     = "NodePort"
}

variable "selector" {
  description = "laravel pod selector"
  type        = string
  default     = "laravel-todo"
}