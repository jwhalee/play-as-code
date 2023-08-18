resource "kubernetes_deployment" "deployment_httpbin" {
  metadata {
    name      = "httpbin"
    namespace = var.namespace-prod
    labels = {
      app = "httpbin"
    }
  }
  spec {
    strategy {
      type = "Recreate"
    }

    replicas = 2

    selector {
      match_labels = {
        app = "httpbin"
      }
    }

    template {
      metadata {
        labels = {
          app = "httpbin"
        }
      }
      spec {
        service_account_name = "test-k6-io"

        image_pull_secrets {
          name = "dockerhub"
        }
        container {
          image             = "grafana/k6-httpbin:v0.7.3"
          name              = "httpbin"
          image_pull_policy = "IfNotPresent"
          security_context {
            run_as_non_root            = true
            run_as_user                = 1000
            allow_privilege_escalation = false
            read_only_root_filesystem  = false
            capabilities {
              drop = [
                "NET_RAW"
              ]
            }
          }
          resources {
            limits = {
              cpu    = "350m"
              memory = "96Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "64Mi"
            }
          }

          port {
            name           = "http"
            container_port = 8080
            protocol       = "TCP"
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            period_seconds    = 10
            timeout_seconds   = 5
            success_threshold = 1
            failure_threshold = 6
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 8080
            }
            initial_delay_seconds = 5
            period_seconds        = 5
            timeout_seconds       = 3
            success_threshold     = 1
            failure_threshold     = 3
          }
        }
        restart_policy = "Always"
      }
    }
  }
}

resource "kubernetes_service" "service_httpbin" {
  metadata {
    labels = {
      app = "httpbin"
    }
    name      = "httpbin"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      app = "httpbin"
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_httpbin" {
  metadata {
    name      = "httpbin"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "k6-http.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "httpbin"
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
}
