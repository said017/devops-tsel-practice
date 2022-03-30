resource "kubernetes_ingress" "ingress-resource" {
  metadata {
    name = var.ingress_name
    namespace = var.ns_name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/issuer" = "${var.issuer_name}"
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
    }
  }
  spec {
    tls {
        hosts = var.hosts
        secret_name = var.secret_name
    }
    rule {
      host = var.host_rule
      http {
        path {
          path = var.path
          backend {
            service_name = var.svc_name
            service_port = var.svc_port
          }
        }
      }
    }
  }
}
