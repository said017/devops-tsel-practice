variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "svc_name" {
  description = "svc name"
  type        = string
  default     = "laravel-service"
}

variable "svc_port" {
  description = "svc port"
  type        = number
  default     = {
      name  = 8080
  }
}

variable "issuer_name" {
  description = "issuer name"
  type        = string
  default     = "letsencrypt-production"
}