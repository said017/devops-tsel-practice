variable "project" {
	type = string
}

variable "vpc_name" {
	type = string
}

variable "description" {
	type = string
}

variable "auto_create_subnet" {
	type = bool
	default = false
}

variable "mtu" {
	type = number
	default = 1500
}


