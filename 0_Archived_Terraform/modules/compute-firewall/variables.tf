variable "fw_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "allow" {
    list(object({
    protocol = string
    ports = list(string)
  }))
}