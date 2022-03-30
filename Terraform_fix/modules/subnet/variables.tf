variable "project" {
	type = string
}

variable "region" {
	type = string
}

variable "subnet_name" {
	type = string
}

variable "description" {
	type = string
}

variable "vpc_net_id" {
	type = string
}

variable "private_ip_google_access" {
	type = bool
}

variable "main_ip_cidr" {
	type = string
}

variable "pod_range_name" {
	type = string
}

variable "pod_ip_cidr" {
	type = string
}

variable "service_range_name" {
	type = string
}

variable "service_ip_cidr" {
	type = string
}