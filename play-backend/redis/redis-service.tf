resource "kubernetes_service" "service_redis" {
  metadata {
    labels = {
      "io.kompose.service" = "redis"
    }
    name      = "redis"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      "io.kompose.service" = "redis"
    }
    port {
      name        = "6379"
      port        = 6379
      target_port = 6379
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
