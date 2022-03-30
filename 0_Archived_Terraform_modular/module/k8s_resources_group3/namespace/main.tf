resource "kubernetes_namespace" "laravel-app-ns" {
  metadata {
    name = var.ns_name
  }
}