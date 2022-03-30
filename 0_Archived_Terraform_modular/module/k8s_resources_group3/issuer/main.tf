resource "kubectl_manifest" "issuer" {
    yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ${var.issuer_name}
  namespace: ${var.ns_name}
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: ${var.email_issuer}
    privateKeySecretRef:
      name: ${var.issuer_name}
    solvers:
    - selector: {}
      http01:
        ingress:
          class: nginx
YAML
}