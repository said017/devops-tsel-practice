resource "kubernetes_service" "svc" {
  metadata {
    name = var.svc_name
    namespace= var.ns_name
  }
  spec {
    selector = var.selector
    port {
      node_port = var.node_port
      port        = var.port
      target_port = var.target_port
      protocol = var.protocol
    }

    type = var.type
  }
}
