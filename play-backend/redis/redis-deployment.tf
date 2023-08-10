resource "kubernetes_deployment" "deployment_redis" {
  metadata {
    name      = "redis"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "redis"
    }
  }
  spec {
    strategy {
      type = "Recreate"
    }

    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "redis"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "redis"
        }
      }
      spec {
        container {
          image = "redis:${var.redis_version}"
          name  = "redis"
          port {
            container_port = 6379
          }
          resources {}
        }
        restart_policy = "Always"
      }
    }
  }
}
