resource "kubernetes_service" "service_influxdb" {
  metadata {
    labels = {
        "io.kompose.service" = "influxdb"
      }
    name = "influxdb"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "influxdb"
      }
    port {
      port        = 80
      target_port = 8086
      name        = "8086"
    }
    load_balancer_ip = var.play_influx_ip

    type = "LoadBalancer"
  }
}
