variable "pod_name" {
  description = "Name of the mysql pod"
  type        = string
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "mysql-ver" {
  description = "My SQL version"
  type        = string
  default     = "5.7.35"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {
      name  = "mysql"
  }
}