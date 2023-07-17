resource "kubernetes_service" "service_kibana" {
  metadata {
    labels = {
        "io.kompose.service" = "kibana"
      }
    name = "kibana"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
        "io.kompose.service" = "kibana"
      }
    port {
      name = "5601"
      port        = 80
      target_port = 5601
    }
    load_balancer_ip = var.play_kibana_ip

    type = "LoadBalancer"
  }
}
