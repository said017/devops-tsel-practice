resource "kubernetes_ingress" "ingress-resource" {
  metadata {
    name = "ingress-resource"
    namespace = var.ns_name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/issuer" = var.issuer_name
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
    }
  }
  spec {
    tls {
        hosts {
            "laravel.freedomvpn.app"
        }
        secret_name = "laravel-group3-tls"
    }
    rule {
      host = "laravel.freedomvpn.app"
      http {
        path {
          path = "/*"
          backend {
            service_name = var.svc_name
            service_port = var.svc_port
          }
        }
      }
    }
  }
}