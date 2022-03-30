output subnet_id {
	value = google_compute_subnetwork.subnet.id
}

output pod_name_id {
	value = google_compute_subnetwork.subnet.secondary_ip_range.0.range_name
}

output pod_cidr_id {
	value = google_compute_subnetwork.subnet.secondary_ip_range.0.ip_cidr_range
}

output service_name_id {
	value = google_compute_subnetwork.subnet.secondary_ip_range.1.range_name
}

output service_cidr_id {
	value = google_compute_subnetwork.subnet.secondary_ip_range.1.ip_cidr_range
}