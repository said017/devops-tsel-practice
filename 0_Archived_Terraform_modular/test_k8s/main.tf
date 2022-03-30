terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.58.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_purwadhika-devops-kelas1_australia-southeast2-a_devops-telkomsel-3"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "gke_purwadhika-devops-kelas1_australia-southeast2-a_devops-telkomsel-3"
}

module "namespace" {
  source           = "../module/k8s_resources_group3/namespace"
  ns_name          = local.ns_name
}

module "mysql_pod" {
  depends_on       = [module.namespace]
  source           = "../module/k8s_resources_group3/db_pod"
  ns_name          = local.ns_name
  pod_name         = local.mysql_pod_name
  mysql-ver        = local.mysql_img_ver
  tags             = local.mysql_pod_tags
}

module "mysql_svc" {
  depends_on       = [module.mysql_pod]
  source           = "../module/k8s_resources_group3/mysql_svc"
  ns_name          = local.ns_name
  svc_name         = local.mysql_svc_name
  selector         = local.mysql_svc_selector
}

module "laravel_deployment" {
  depends_on       = [module.mysql_svc]
  source           = "../module/k8s_resources_group3/laravel-deployment"
  ns_name          = local.ns_name
  dep_name         = local.dep_name
  image            = local.dep_image
  tags             = local.dep_tags
  mysql_svc        = local.mysql_svc_name
}

module "laravel_hpa" {
  depends_on       = [module.laravel_deployment]
  source           = "../module/k8s_resources_group3/hpa"
  ns_name          = local.ns_name
  hpa_name         = local.hpa_name
  selector         = local.hpa_selector
  utilization      = local.hpa_util
  minReplicas      = local.hpa_minRep
  maxReplicas      = local.hpa_maxRep
}

module "laravel_svc" {
  depends_on       = [module.laravel_deployment]
  source           = "../module/k8s_resources_group3/laravel_svc"
  ns_name          = local.ns_name
  svc_name         = local.dep_svc_name
  node_port_number = local.dep_node_port_number
  svc_type         = local.dep_svc_type
  selector         = local.dep_selector
}

// ingress controller resources

module "namespace_ingress" {
  source           = "../module/k8s_resources_group3/namespace"
  ns_name          = local.ns_ingress_name
}

module "ingress_controller" {
  depends_on       = [module.namespace_ingress]
  source           = "../module/k8s_resources_group3/ingress-controller"
  ns_ingress_name  = local.ns_ingress_name
}

// cert manager

module "namespace_cert" {
  depends_on       = [module.ingress_controller]
  source           = "../module/k8s_resources_group3/namespace"
  ns_name          = local.ns_cert_name
}

module "cert_manager" {
  depends_on       = [module.namespace_cert]
  source           = "../module/k8s_resources_group3/cert-manager"
  ns_ingress_name  = local.ns_cert_name
}

// cert issuer

module "issuer" {
  depends_on       = [module.cert_manager]
  source           = "../module/k8s_resources_group3/issuer"
  issuer_name      = local.issuer_name
  ns_name          = local.ns_name
  email_issuer     = local.email_issuer
}

// ingress 

module "ingress" {
  depends_on       = [module.issuer]
  source           = "../module/k8s_resources_group3/ingress"
  ns_name          = local.ns_name
  email_issuer     = local.email_issuer
  svc_name         = local.dep_svc_name
  svc_port         = local.dep_svc_port
  issuer_name      = local.issuer_name
}


