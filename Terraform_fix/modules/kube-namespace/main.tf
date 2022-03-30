resource "kubernetes_namespace" "namespace" {
  metadata {
    # annotations = {
    #   name = "example-annotation"
    # }

    # labels = {
    #   mylabel = "label-value"
    # }

    name = var.namespace
  }
}