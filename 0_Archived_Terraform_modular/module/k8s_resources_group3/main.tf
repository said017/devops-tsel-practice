terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
  }
}

resource "kubernetes_namespace" "laravel-app-ns" {
  metadata {
    name = var.ns_name
  }
}

resource "kubernetes_pod" "mysql-pod" {
  metadata {
    name = "mysql"
    labels = {
      name  = "mysql"
    }
    namespace = kubernetes_namespace.laravel-app-ns.metadata.0.name
  }

  spec {
    container {
      image = "mysql:5.7.35"
      name  = "mysql"

      env {
        name  = "MYSQL_ROOT_PASSWORD"
        value = "secret"
      }

      env {
        name  = "MYSQL_USER"
        value = "laravel"
      }

      env {
        name  = "MYSQL_DATABASE"
        value = "laravel"
      }

      env {
        name  = "MYSQL_PASSWORD"
        value = "secret"
      }

      port {
        container_port = 3306
        protocol = "TCP"
      }

    }

  }
}

resource "kubernetes_deployment" "laravel-app" {
  metadata {
    name = "laravel-todo"
    labels = {
      app  = "laravel-todo"
    }
    namespace= kubernetes_namespace.laravel-app-ns.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "laravel-todo"
      }
    }
    template {
      metadata {
        labels = {
          app  = "laravel-todo"
        }
      }
      spec {
        init_container {
          image = "busybox:1.28"
          name  = "init-db"
          command = [
              "sh",
              "-c",
              "until nslookup mysql-service; do echo waiting for db; sleep 2; done;"
          ]

        }
        container {
          image = "said017/laravel-group3-todo"
          name  = "web"

          command = [
              "/bin/bash",
              "-c",
              "php artisan key:generate && php artisan migrate --force && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=8080"
          ]

          resources {
            limits = {
              memory = "1024M"
              cpu = "1"
            }
            requests = {
              memory = "512M"
              cpu = "500m"
            }
          }
          port {
            container_port = 8080
          }
          
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql-svc" {
  metadata {
    name = "mysql-service"
    namespace= kubernetes_namespace.laravel-app-ns.metadata.0.name
  }
  spec {
    selector = {
      name = kubernetes_pod.mysql-pod.metadata.0.labels.name
    }
    port {
      port        = 3306
      target_port = 3306
      protocol = "TCP"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "laravel-svc" {
  metadata {
    name = "laravel-service"
    namespace= kubernetes_namespace.laravel-app-ns.metadata.0.name
  }
  spec {
    external_traffic_policy = "Cluster"
    selector = {
      app = kubernetes_deployment.laravel-app.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 8080
      node_port   = 30081
      protocol    = "TCP"
    }

    type = "NodePort"
  }
}