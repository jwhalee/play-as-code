resource "kubernetes_deployment" "deployment_opentsdb" {
  metadata {
    name = "opentsdb"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "opentsdb"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

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
          name = "opentsdb"
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
    name = "opentsdb"
    namespace = var.namespace-prod
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
