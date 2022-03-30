resource "kubernetes_service" "laravel-svc" {
  metadata {
    name = var.svc_name
    namespace= var.ns_name
  }
  spec {
    external_traffic_policy = "Cluster"
    selector = {
      app = var.selector
    }
    port {
      port        = 8080
      target_port = 8080
      node_port   = var.node_port_number
      protocol    = "TCP"
    }

    type = var.svc_type
  }
}