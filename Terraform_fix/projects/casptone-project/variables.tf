variable "project" {
	type = string
	default = "purwadhika-devops-kelas1"
}

variable "region" {
	type = string
	default = "australia-southeast2"
}

variable "zones" {
	type = string
	default = "australia-southeast2-a"
}

variable "sa" {
	type = string
	# default = "terraform-test@symmetric-lore-258610.iam.gserviceaccount.com"
	default = "devops-group3@purwadhika-devops-kelas1.iam.gserviceaccount.com"
}

variable "secret_json" {
	type = string
}