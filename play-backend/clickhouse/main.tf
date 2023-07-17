resource "kubernetes_deployment" "deployment_clickhouse" {
  metadata {
    name = "clickhouse"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "clickhouse"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "clickhouse"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "clickhouse"
        }
      }
      spec {
        container {
          image = "clickhouse/clickhouse-server:${var.clickhouse_version}"
          name = "clickhouse"
          port {
            container_port = 8123
            }
          resources {}
         
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "service_clickhouse" {
  metadata {
    labels = {
        "io.kompose.service" = "clickhouse"
      }
    name = "clickhouse"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
        "io.kompose.service" = "clickhouse"
      }
    port {
      port        = 80
      target_port = 8123
      name        = "8123"
    }
    load_balancer_ip = var.play_clickhouse_ip

    type = "LoadBalancer"
  }
}