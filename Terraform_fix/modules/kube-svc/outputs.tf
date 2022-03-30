output svc_name {
    value = kubernetes_service.svc.metadata.0.name
}