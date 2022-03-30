resource helm_release nginx_ingress {
  name       = "nginx-ingress-controller"
  namespace  =  var.ns_ingress_name

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx/ingress-nginx"

  set {
    rbac.create  = true
    controller.publishService.enabled = true
  }
}