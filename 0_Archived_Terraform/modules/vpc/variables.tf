variable "gcp_vpc_name" {
	type = string
	description = "Name of VPC Network GCP"
	default = ""
}

variable "source_ranges" {
	type = list(string)
}

variable "gcp_vpc_desc" {
	type = string
	description = "Description of VPC"
	default = ""
}

variable "auto_create_subnet" {
	type = bool
	description = "on or off auto create subnet"
	default = false
}

variable "mtu" {
	type = number
	default = 1500
}

variable "project" {
	type = string
	default = ""
}

