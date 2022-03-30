variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "email_issuer" {
  description = "issuer email"
  type        = string
  default     = "saidam017@gmail.com"
}

variable "issuer_name" {
  description = "issuer name"
  type        = string
  default     = "letsencrypt-production"
}
