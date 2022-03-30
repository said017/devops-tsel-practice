locals {
  // namespace variable
  ns_name = "laravel"
  // mysql variables
  mysql_pod_name = "mysql"
  mysql_img_ver = "5.7.35"
  mysql_pod_tags = {
      name  = "mysql"
  }
  // mysql service variables
  mysql_svc_name = "mysql-service"
  mysql_svc_selector = "mysql"
  // deployment variables
   dep_name = "laravel-todo"
   dep_image = "said017/laravel-group3-todo"
   dep_tags = {
      app  = "laravel-todo"
  }
  // hpa laravel variables
  hpa_name = "laravel-hpa"
  hpa_selector = "laravel-todo"
  hpa_util = "70"
  hpa_minRep = 2
  hpa_maxRep = 4
  // deployment service variables
  dep_svc_name = "laravel-service"
  dep_node_port_number = 30081
  dep_svc_port = 8080
  dep_svc_type = "NodePort"
  dep_selector = "laravel-todo"
  // ingress resources
   ns_ingress_name = "nginx"
  // cert manager resources
  ns_cert_name = "cert-manager"
  email_issuer = "saidam017@gmail.com"
  issuer_name = "letsencrypt-production"
}