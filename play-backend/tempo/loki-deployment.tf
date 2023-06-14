resource "kubernetes_manifest" "deployment_loki" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "kompose.cmd" = "kompose convert"
        "kompose.version" = "1.28.0 (HEAD)"
        "namespace" = "monitoring"
      }
      "labels" = {
        "io.kompose.service" = "loki"
      }
      "name" = "loki"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "loki"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "annotations" = {
            "kompose.cmd" = "kompose convert"
            "kompose.version" = "1.28.0 (HEAD)"
            "namespace" = "monitoring"
          }
          "labels" = {
            "io.kompose.network/tempo-default" = "true"
            "io.kompose.service" = "loki"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "-config.file=/etc/loki/local-config.yaml",
                "-table-manager.retention-period=1d",
                "-table-manager.retention-deletes-enabled=true",
              ]
              "image" = "grafana/loki:main"
              "name" = "loki"
              "ports" = [
                {
                  "containerPort" = 3100
                },
              ]
              "resources" = {}
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}
