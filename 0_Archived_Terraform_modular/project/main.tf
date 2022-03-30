module "group3-gke" {
	source = "../module/gke_group3"
        project = "purwadhika-devops-kelas1"

	# access_token ganti sesuai credential
	# cek di 'kubectl config view'
	access_token = "ya29.a0ARrdaM8r_97QW-iKqJ1GNtOt-4Tm23XB-_J-hTEOFkcIJOdKwIQkP46Yrsb0hWvLS80YySDx5FC7uQPhUUBXL6Yw_HBBzwGoR85qyYSz9KJUkEGOzhxFdpWDwLfyrtS86rlVLzHqZqNjyQGLu0kCQLEC-TXQ2EZxiXYM"

	cluster_name = "devops-telkomsel-3"
	location = "australia-southeast2-a"
	region = "australia-southeast2"
        vpc_name = "devops-telkomsel-3-vpc"
        subnet_name = "devops-telkomsel-3-public-subnet"
        public_subnet_cidr = "20.20.20.0/24"
	public_endpoint_ipv4 = "34.129.151.65"
	master_private_ipv4_cidr = "172.16.0.0/28"
	node_count = 2
	machine_type = "e2-medium"
	gke_min_nodes_per_zone = 2
	gke_max_nodes_per_zone = 4
}

