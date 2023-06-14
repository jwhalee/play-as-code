resource "kubernetes_deployment" "deployment_clickhouse" {
  metadata {
    name = "clickhouse"
    namespace = var.namespace
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
          image = "clickhouse/clickhouse-server:${clickhouse_version}"
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
    namespace = var.namespace
  }
  spec {
    selector = {
        "io.kompose.service" = "clickhouse"
      }
    port {
      port        = 8123
      target_port = 8123
      name        = "8123"
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}