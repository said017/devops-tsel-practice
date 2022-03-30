variable "hpa_name" {
  description = "Name of the hpa"
  type        = string
  default     = "laravel-hpa"
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "selector" {
  description = "Name of the deployment"
  type        = string
}

variable "utilization" {
  description = "Util threshold"
  type        = string
  default     ="70"
}

variable "minReplicas" {
  description = "Min Replicas"
  type        = number
  default     = 2
}

variable "maxReplicas" {
  description = "Max Replicas"
  type        = number
  default     = 4
}