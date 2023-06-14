resource "kubernetes_service" "service_mysql" {
  metadata {
    labels = {
        "io.kompose.service" = "mysql"
      }
    name = "mysql"
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "mysql"
      }
    port {
      name        = "3306"
      port        = 3306
      target_port = 3306
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
