resource "kubernetes_deployment" "deployment_opentsdb" {
  metadata {
    name = "opentsdb"
    namespace = var.namespace
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

