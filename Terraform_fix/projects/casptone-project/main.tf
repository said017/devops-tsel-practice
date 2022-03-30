module "vpc_net" {
  source = "../../modules/vpc"
  project = var.project
  vpc_name = "vpc-devops-telkomsel-3"
  description = "vpc network group 3"
  auto_create_subnet = false
  mtu = 1500
}

# module "firewall" {
#   source = "../../modules/compute-firewall"
#   project = var.project
#   description = "firewall group 3"
#   fw_name = "fw-devops-telkomsel-3"
#   vpc_id = module.vpc_net.vpc_id
#   source_ranges = ["0.0.0.0/0"]
#   target_tags = ["runner"]
#   protocol = "tcp"
#   ports = ["22", "80", "8080", "443", "3306"]
# }

module "subnet" {
  source = "../../modules/subnet"
  project = var.project
  region = var.region
  subnet_name = "subnet-devops-telkomsel-3"
  description = "subnetwork group 3"
  vpc_net_id = module.vpc_net.vpc_id
  main_ip_cidr = "10.10.0.0/27"
  private_ip_google_access = true
  pod_range_name = "subnet-pod-telkomsel-3"
  pod_ip_cidr = "10.0.0.0/21"
  service_range_name = "subnet-service-telkomsel-3"
  service_ip_cidr = "10.4.0.0/20"
}

module "cloud-nat" {
  source = "../../modules/cloud-nat"
  router_name = "nat-telkomsel-3"
  nat_name = "router-telkomsel-3"
  region = var.region
  network_id = module.vpc_net.vpc_id
  
}

# module "address" {
#   source = "../../modules/compute-address"
#   project = var.project
#   region = var.region
#   address_name = "external-ip-runner3"
#   description = "static ip external for vm runner"
#   address_type = "EXTERNAL"
#   network_tier = "PREMIUM"
# }

# module "instance" {
#   source = "../../modules/compute-instance"
#   project = var.project
#   zone = var.zones
#   description = "vm gitlab runner"
#   instance_name = "vm-devops-telkomsel-3"
#   machine_type = "e2-medium"
#   tags = ["server", "runner"]
#   allow_stopping_vm = true
#   image = "ubuntu-minimal-2004-focal-v20210720"
#   vpc_net_id = module.vpc_net.vpc_id
#   subnet_id = module.subnet.subnet_id
#   address_id = module.address.static_external_ip
#   startup_script = "${file("startup.sh")}"
#   depends_on = [module.address]
# }

module "private_cluster" {
  source = "../../modules/private-cluster"
  project = var.project
  location = var.zones
  cluster_name = "devops-telkomsel-3"
  description = "private cluster group 3"
  vpc_net_id = module.vpc_net.vpc_id
  subnet_id = module.subnet.subnet_id
  remove_default_pool = true
  initial_node_count = 1
  pod_range_name = module.subnet.pod_name_id
  service_range_name = module.subnet.service_name_id
  enable_private_nodes = true
  enable_private_endpoint = false
  master_ipv4_cidr_block = "172.16.10.0/28"
  #default hp arg "disable" = true 
  hpa = false
  depends_on = [module.subnet]
}

module "node_pool" {
  source = "../../modules/node-pool"
  project = var.project
  pool_name = "nodepool-devops-telkomsel-3"
  location = var.zones
  cluster_id = module.private_cluster.cluster_id
  initial_node_count = 2
  min_node_count = 2
  max_node_count = 4
  preemptible = true
  machine_type = "e2-medium"
  sa = var.sa
  oauth_scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
  depends_on = [module.private_cluster]
}

resource "time_sleep" "wait_120_sec" {
  create_duration = "120s"
  depends_on = [module.node_pool]
}

module "ns_laravel" {
  source = "../../modules/kube-namespace"
  namespace = "laravel"
  depends_on = [time_sleep.wait_120_sec]
}

module "db_pod" {
  source = "../../modules/kube-pod"
  ns_name = module.ns_laravel.ns_name
  tags = {apps = "mysql" }
  pod_name = "mysql"
  image_name = "mysql"
  image_ver = "5.7.35"
  env_name_0 = "MYSQL_ROOT_PASSWORD"
  env_value_0 = "secret"
  env_name_1 = "MYSQL_USER"
  env_value_1 = "laravel"
  env_name_2 = "MYSQL_DATABASE"
  env_value_2 = "laravel"
  env_name_3 = "MYSQL_PASSWORD"
  env_value_3 = "secret"
  container_port = 3306
  protocol = "TCP"
  depends_on = [time_sleep.wait_120_sec]
}

module "db_svc" {
  source = "../../modules/kube-svc"
  svc_name = "mysql-service"
  ns_name = module.ns_laravel.ns_name
  selector = {apps = "mysql"}
  node_port = null
  port = 3306
  target_port = 3306
  protocol = "TCP"
  type = "ClusterIP"
}

module "gitlab-secret" {
  source = "../../modules/kube-secret"
  secret_name = "gitlab-secret"
  namespace = module.ns_laravel.ns_name
  secret_json = var.secret_json
  depends_on = [module.db_svc]
}

module "laravel_deployment" {
  depends_on = [module.gitlab-secret]
  source = "../../modules/kube-deployment"
  dep_name = "laravel-todo"
  tags = {app = "laravel-todo"}
  ns_name = module.ns_laravel.ns_name
  replicas = 2
  init_image_name = "registry.gitlab.com/devops-tsel-03/lavarel-cicd/busybox"
  init_image_ver = "1.28"
  init_cont_name = "init-db"
  init_cont_comm = ["sh", 
              "-c",
              "until nslookup ${module.db_svc.svc_name}; do echo waiting for db; sleep 2; done;"]
  image_name = "registry.gitlab.com/devops-tsel-03/lavarel-cicd/laravel"
  cont_name = "laravel-todo"
  image_pull_policy = "Always"
  secret_name = "gitlab-secret"
  command = ["/bin/bash",
              "-c",
              "php artisan key:generate && php artisan migrate --force  && php artisan config:cache && php artisan serve --host=0.0.0.0 --port=8080"]
  cont_port = 8080
}

module "hpa" {
  source = "../../modules/kube-hpa"
  hpa_name = "laravel-hpa"
  ns_name = module.ns_laravel.ns_name
  min_replicas = 2
  max_replicas = 4
  kind_name = "Deployment"
  dep_name = module.laravel_deployment.dep_name
  type_metric_1 = "Resource"
  resource_name_1 = "CPU"
  target_type_1 = "Utilization"
  type_metric_2 = "Resource"
  resource_name_2 = "memory"
  target_type_2 = "Utilization"
  avg_utilization = "70"
}

module "laravel_svc" {
  source = "../../modules/kube-svc"
  svc_name = "laravel-service"
  ns_name = module.ns_laravel.ns_name
  selector = {app = "laravel-todo"}
  node_port = 30081
  port = 8080
  target_port = 8080
  protocol = "TCP"
  type = "NodePort"
}

module "ns_ingress" {
  source = "../../modules/kube-namespace"
  namespace = "ingress"
  depends_on = [module.laravel_svc]
}

module "ingress_controller" {
  source = "../../modules/helm-ingress"
  ingress_name = "nginx-ingress-controller"
  ns_name  = module.ns_ingress.ns_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  set_name_1 = "rbac.create"
  set_value_1 = "true"
  set_name_2 = "controller.publishService.enabled"
  set_value_2 = "true"
  set_name_3 = "controller.admissionWebhooks.enabled"
  set_value_3 = "false"
  depends_on = [module.ns_ingress]
}

module "ns_cert" {
  source = "../../modules/kube-namespace"
  namespace = "cert-manager"
  depends_on = [module.ingress_controller]
#   depends_on = [module.laravel_svc]
 }

module "cert_manager" {
  source = "../../modules/helm-cert-manager"
  cert_manager_name = "cert-manager"
  ns_name  = module.ns_cert.ns_name
  # version = "v1.5.0"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  set_name_1 = "installCRDs"
  set_value_1 = "true"
  depends_on = [module.ns_cert]
}

module "issuer" {
  depends_on = [module.cert_manager]
  source = "../../modules/issuer"
  issuer_name = "encrypt-laravel"
  ns_name = module.ns_laravel.ns_name
  email_issuer = "saidam017@gmail.com"
}

module "ingress" {
  depends_on = [module.issuer]
  source = "../../modules/ingress"
  ingress_name = "ingress-laravel"
  ns_name = module.ns_laravel.ns_name
  issuer_name = "encrypt-laravel"
  hosts = ["laravel.freedomvpn.app"]
  secret_name = "laravel-group3-tls"
  host_rule = "laravel.freedomvpn.app"
  path = "/"
  svc_name = module.laravel_svc.svc_name
  svc_port = 8080
}