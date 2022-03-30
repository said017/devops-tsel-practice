resource "kubernetes_pod" "mysql-pod" {
  metadata {
    name = var.pod_name
    labels = var.tags
    namespace = var.ns_name
  }

  spec {
    container {
      image = "${var.image_name}:${var.image_ver}"
      name  = var.pod_name
      env {
        name  = var.env_name_0
        value = var.env_value_0
      }

      env {
        name  = var.env_name_1
        value = var.env_value_1
      }

      env {
        name  = var.env_name_2
        value = var.env_value_2
      }

      env {
        name  = var.env_name_3
        value = var.env_value_3
      }

      port {
        container_port = var.container_port
        protocol = var.protocol
      }

    }

  }
}
