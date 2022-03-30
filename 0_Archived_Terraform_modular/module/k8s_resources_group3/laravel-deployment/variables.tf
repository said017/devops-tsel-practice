variable "dep_name" {
  description = "Name of the laravel deployment"
  type        = string
}

variable "ns_name" {
  description = "Name of the Namespace"
  type        = string
}

variable "mysql_svc" {
  description = "My SQL svc name"
  type        = string
  default     = "mysql-service"
}

variable "image" {
  description = "laravel docker image"
  type        = string
  default     = "said017/laravel-group3-todo"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {
      app  = "laravel-todo"
  }
}

