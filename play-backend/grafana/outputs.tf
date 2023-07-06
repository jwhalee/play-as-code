output "grafana_ip" {
  value = kubernetes_service.service_grafana.status.0.load_balancer.0.ingress.0.ip
}