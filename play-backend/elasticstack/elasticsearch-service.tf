resource "kubernetes_service" "service_elasticsearch" {
  metadata {
    labels = {
        "io.kompose.service" = "elasticsearch"
      }
    name = "elasticsearch"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "elasticsearch"
      }
    port {
      name = "9200"
      port        = 80
      target_port = 9200
    }
    load_balancer_ip = var.play_elastic_ip

    type = "LoadBalancer"
  }
}
