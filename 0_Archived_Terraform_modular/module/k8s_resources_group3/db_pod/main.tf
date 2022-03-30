resource "kubernetes_pod" "mysql-pod" {
  metadata {
    name = var.pod_name
    labels = var.tags
    namespace = var.ns_name
  }

  spec {
    container {
      image = "mysql:${var.mysql-ver}"
      name  = var.pod_name

      env {
        name  = "MYSQL_ROOT_PASSWORD"
        value = "secret"
      }

      env {
        name  = "MYSQL_USER"
        value = "laravel"
      }

      env {
        name  = "MYSQL_DATABASE"
        value = "laravel"
      }

      env {
        name  = "MYSQL_PASSWORD"
        value = "secret"
      }

      port {
        container_port = 3306
        protocol = "TCP"
      }

    }

  }
}