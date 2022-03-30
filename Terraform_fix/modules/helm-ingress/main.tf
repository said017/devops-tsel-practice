resource "helm_release" "nginx_ingress" {
  name       = var.ingress_name
  namespace  =  var.ns_name

  repository = var.repository
  chart      = var.chart

  set {
    name = var.set_name_1
    value = var.set_value_1
  }
  
  set {
    name = var.set_name_2
    value = var.set_value_2
  }

    set {
    name = var.set_name_3
    value = var.set_value_3
  }
}
