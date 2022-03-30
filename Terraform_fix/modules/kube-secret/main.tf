resource "kubernetes_secret" "gitlab-secret" {
  metadata {
    name = var.secret_name
    namespace = var.namespace
  }

  data = {
    ".dockerconfigjson" = "${var.secret_json}"
  }

  type = "kubernetes.io/dockerconfigjson"
}