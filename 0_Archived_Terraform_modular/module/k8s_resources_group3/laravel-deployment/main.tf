resource "kubernetes_deployment" "laravel-app" {
  metadata {
    name = var.dep_name
    labels = var.tags
    namespace= var.ns_name
  }
  spec {
    replicas = 2
    selector {
      match_labels = var.tags
    }
    template {
      metadata {
        labels = var.tags
      }
      spec {
        init_container {
          image = "busybox:1.28"
          name  = "init-db"
          command = [
              "sh",
              "-c",
              "until nslookup ${var.mysql_svc}; do echo waiting for db; sleep 2; done;"
          ]

        }
        container {
          image = var.image
          name  = var.dep_name
          image_pull_policy = "Always"

          command = [
              "/bin/bash",
              "-c",
              "php artisan key:generate && php artisan migrate --force  && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=8080"
          ]
          port {
            container_port = 8080
          }
          
        }
      }
    }
  }
}