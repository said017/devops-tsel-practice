variable "vpc_network_id" {
	type = string
}

variable "project" {
	type = string
	default = ""
}

variable "subnet_name" {
}

variable "private_ip_google_access" {
	type = bool
}

variable "subnet_desc" {
	type = string
	default = ""
}


variable "main_ip_cidr" {
	type = string
	default = ""
}


variable "region" {
	type = string
	default = ""
}

variable "secondary_range_name" {

}

variable "secondary_ip_cidr" {

}
