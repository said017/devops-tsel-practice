resource helm_release cert-manager {
  name       = "cert-manager"
  namespace  =  var.ns_cert_name
  version    = "v1.5.0"

  repository = "https://charts.jetstack.io"
  chart      = "jetstack/cert-manager"

  set {
    installCRDs = true
  }
}