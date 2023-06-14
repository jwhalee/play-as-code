resource "kubernetes_service" "service_grafana" {
  metadata {
    labels = {
        "io.kompose.service" = "grafana"
      }
    name = "grafana"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "grafana"
      }
    port {
      name = "3000"
      port        = 80
      target_port = 3000
    }
    load_balancer_ip = var.play_dev_ip

    type = "LoadBalancer"
  }
}
