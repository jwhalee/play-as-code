resource "kubernetes_deployment" "deployment_k6test" {
  metadata {
    name      = "k6-php"
    namespace = var.namespace-prod
    labels = {
      app = "k6-php"
    }
  }
  spec {
    strategy {
      type = "Recreate"
    }

    replicas = 2

    selector {
      match_labels = {
        app = "k6-php"
      }
    }

    template {
      metadata {
        labels = {
          app = "k6-php"
        }
      }
      spec {
        service_account_name = "k6-php"

        image_pull_secrets {
          name = "dockerhub"
        }
        container {
          image             = "grafana/test.k6.io:v0.0.5"
          name              = "k6-php"
          image_pull_policy = "IfNotPresent"
          security_context {
            run_as_non_root            = false
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
              cpu    = "70m"
              memory = "96Mi"
            }
            requests = {
              cpu    = "50m"
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

resource "kubernetes_service" "service_k6test" {
  metadata {
    labels = {
      app = "k6-php"
    }
    name      = "k6-php"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      app = "k6-php"
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_k6test" {
  metadata {
    name      = "k6-php"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "k6-php.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "k6-php"
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

resource "kubernetes_service_account_v1" "service_account_k6" {
  metadata {
    name      = "k6-php"
    namespace = var.namespace-prod
  }
  image_pull_secret {
    name = "dockerhub"
  }
}