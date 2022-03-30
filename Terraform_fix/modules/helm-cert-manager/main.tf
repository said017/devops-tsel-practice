resource "helm_release" "cert-manager" {
  name       = var.cert_manager_name
  namespace  =  var.ns_name
  # version    = var.version

  repository = var.repository
  chart      = var.chart

  set {
    name = var.set_name_1
    value = var.set_value_1
  }
}
