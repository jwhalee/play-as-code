resource "kubernetes_deployment" "deployment_opentsdb" {
  metadata {
    name      = "opentsdb"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "opentsdb"
    }
  }
  spec {
    strategy {
      type = "Recreate"
    }

    replicas = 2

    selector {
      match_labels = {
        "io.kompose.service" = "opentsdb"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "opentsdb"
        }
      }
      spec {
        container {
          image = "petergrace/opentsdb-docker:latest"
          name  = "opentsdb"
          port {
            container_port = 4242
          }
          resources {}
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "service_opentsdb" {
  metadata {
    labels = {
      "io.kompose.service" = "opentsdb"
    }
    name      = "opentsdb"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      "io.kompose.service" = "opentsdb"
    }
    port {
      port        = 4242
      target_port = 4242
      name        = "4242"
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_opentsdb" {
  metadata {
    name      = "opentsdb"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "opentsdb.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "opentsdb"
              port {
                number = 4242
              }
            }
          }
        }
      }
    }
  }
}