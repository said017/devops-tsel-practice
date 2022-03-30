resource "kubernetes_service" "mysql-svc" {
  metadata {
    name = var.svc_name
    namespace= var.ns_name
  }
  spec {
    selector = {
      name = var.selector
    }
    port {
      port        = 3306
      target_port = 3306
      protocol = "TCP"
    }

    type = "ClusterIP"
  }
}