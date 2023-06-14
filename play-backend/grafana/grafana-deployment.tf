resource "kubernetes_manifest" "deployment_grafana" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "grafana"
      }
      "name" = "grafana"
      "namespace" = "matt-sandbox"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "grafana"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            # "io.kompose.network/grafana-default" = "true"
            "io.kompose.service" = "grafana"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "grafana/grafana:${var.grafana_version}"
              "name" = "grafana"
              "ports" = [
                {
                  "containerPort" = 3000
                },
              ]
              "resources" = {}
              # "volumeMounts" = [
              #   {
              #     "mountPath" = "/etc/grafana/provisioning/dashboards/dashboards.yaml"
              #     "name" = "grafana-claim0"
              #   },
              #   {
              #     "mountPath" = "/usr/share/grafana/devenv/dev-dashboards"
              #     "name" = "grafana-claim1"
              #   },
              #   {
              #     "mountPath" = "/etc/grafana/provisioning/datasources/datasources.yaml"
              #     "name" = "grafana-claim2"
              #   },
              # ]
            },
          ]
          "restartPolicy" = "Always"
          # "volumes" = [
          #   {
          #     "name" = "grafana-claim0"
          #     "persistentVolumeClaim" = {
          #       "claimName" = "grafana-claim0"
          #     }
          #   },
          #   {
          #     "name" = "grafana-claim1"
          #     "persistentVolumeClaim" = {
          #       "claimName" = "grafana-claim1"
          #     }
          #   },
          #   {
          #     "name" = "grafana-claim2"
          #     "persistentVolumeClaim" = {
          #       "claimName" = "grafana-claim2"
          #     }
          #   },
          # ]
        }
      }
    }
  }
}
