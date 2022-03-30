resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = var.hpa_name
    namespace = var.ns_name
  }

  spec {
    max_replicas = var.maxReplicas
    min_replicas = var.minReplicas

    scale_target_ref {
      kind = "Deployment"
      name = var.selector
    }

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type  = "Utilization"
          average_utilization = var.utilization
        }
      }     
    }
    metric {
        type = "Resource"
      resource {
        name = "memory"
        target {
          type  = "Utilization"
          average_utilization = var.utilization
        }
      }     
    }
  }
}