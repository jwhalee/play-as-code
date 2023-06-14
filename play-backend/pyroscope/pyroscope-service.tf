resource "kubernetes_service" "service_pyroscope" {
  metadata {
    labels = {
        "io.kompose.service" = "pyroscope"
      }
    name = "pyroscope"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "pyroscope"
      }
    port {
      name        = "4040"
      port        = 4040
      target_port = 4040
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
