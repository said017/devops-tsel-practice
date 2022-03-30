resource "kubernetes_horizontal_pod_autoscaler" "hpa" {
  metadata {
    name = var.hpa_name
    namespace = var.ns_name
  }

  spec {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas
    scale_target_ref {
      kind = var.kind_name
      name = var.dep_name
    }

    metric {
      type = var.type_metric_1
      resource {
        name = var.resource_name_1
        target {
          type  = var.target_type_1
          average_utilization = var.avg_utilization
        }
      }     
    }
    metric {
      type = var.type_metric_2
      resource {
        name = var.resource_name_2
        target {
          type  = var.target_type_2
          average_utilization = var.avg_utilization
        }
      }     
    }
  }
}
