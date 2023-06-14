resource "kubernetes_service" "service_opentsdb" {
  metadata {
    labels = {
        "io.kompose.service" = "opentsdb"
      }
    name = "opentsdb"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "opentsdb"
      }
    port {
      port        = 80
      target_port = 4242
      name        = "4242"
    }
    load_balancer_ip = var.ip

    type = "LoadBalancer"
  }
}
