resource "kubernetes_service" "service_phlare" {
  metadata {
    labels = {
        "io.kompose.service" = "phlare"
      }
    name = "phlare"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "phlare"
      }
    port {
      name        = "4100"
      port        = 4100
      target_port = 4100
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
