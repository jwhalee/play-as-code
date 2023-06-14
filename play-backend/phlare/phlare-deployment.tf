resource "kubernetes_deployment" "deployment_phlare" {
  metadata {
    name = "phlare"
    namespace = var.namespace
    labels = {
      "io.kompose.service" = "phlare"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "phlare"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "phlare"
        }
      }
      spec {
        container {
          # args = ["--config.file=/etc/phlare.yaml"]
          image = "grafana/phlare:latest"
          name = "phlare"
          port {
            container_port = 4100
            }
          resources {}
          volume_mount {
            mount_path = "/etc/phlare.yaml"
            name = "phlare-config"
            # sub_path = "setup.sh"
          }
        }
        restart_policy = "Always"
        volume {
          name = "phlare-config"
          config_map {
            name = "phlare-configmap"
          }
        }
      }
    }
  }
}
