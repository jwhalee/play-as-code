resource "kubernetes_deployment" "deployment_pyroscope" {
  metadata {
    name = "pyroscope"
    namespace = var.namespace
    labels = {
      "io.kompose.service" = "pyroscope"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "pyroscope"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "pyroscope"
        }
      }
      spec {
        container {
          image = "pyroscope/pyroscope:${pyroscope_version}"
          name = "pyroscope"
          port {
            container_port = 4040
            }
          resources {}
        }
      }
    }
  }
}
