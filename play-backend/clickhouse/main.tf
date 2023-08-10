resource "kubernetes_deployment" "deployment_clickhouse" {
  metadata {
    name      = "clickhouse"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "clickhouse"
    }
  }
  spec {
    strategy {
      type = "Recreate"
    }

    replicas = 3

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
          name  = "clickhouse"
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
    name      = "clickhouse"
    namespace = var.namespace-prod
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
  }
}

resource "kubernetes_ingress_v1" "ingress_clickhouse" {
  metadata {
    name      = "clickhouse"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "clickhouse.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "clickhouse"
              port {
                number = 8123
              }
            }
          }
        }
      }
    }
  }
}