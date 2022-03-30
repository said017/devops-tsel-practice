variable "app_name" {
  description = "Name of the App"
  type        = string
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}