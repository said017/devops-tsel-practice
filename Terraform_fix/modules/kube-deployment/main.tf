resource "kubernetes_deployment" "deployment" {
  metadata {
    name = var.dep_name
    labels = var.tags
    namespace= var.ns_name
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = var.tags
    }
    template {
      metadata {
        labels = var.tags
      }
      spec {
        init_container {
          image = "${var.init_image_name}:${var.init_image_ver}"
          name  = var.init_cont_name
          command = var.init_cont_comm
        }
        container {
          image = var.image_name
          name  = var.cont_name
          image_pull_policy = "Always"
          command = var.command
          port {
            container_port = var.cont_port
          }
        }
          image_pull_secrets {
            name = var.secret_name
        }
      }
    }
  }
}
