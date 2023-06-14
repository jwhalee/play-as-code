resource "kubernetes_manifest" "deployment_tempo" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "tempo"
      }
      "name" = "tempo"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "tempo"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "io.kompose.network/tempo-default" = "true"
            "io.kompose.service" = "tempo"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--config.file=/etc/tempo.yaml",
                "--search.enabled=true",
              ]
              "image" = "grafana/tempo:main-9a8474f"
              "name" = "tempo"
              "ports" = [
                {
                  "containerPort" = 14268
                },
                {
                  "containerPort" = 3200
                },
                {
                  "containerPort" = 4317
                },
                {
                  "containerPort" = 4318
                },
              ]
              "resources" = {}
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/tempo.yaml"
                  "name" = "tempo-claim0"
                },
                {
                  "mountPath" = "/tmp/tempo"
                  "name" = "tempo-claim1"
                },
              ]
            },
          ]
          "restartPolicy" = "Always"
          "volumes" = [
            {
              "name" = "tempo-claim0"
              "persistentVolumeClaim" = {
                "claimName" = "tempo-claim0"
              }
            },
            {
              "name" = "tempo-claim1"
              "persistentVolumeClaim" = {
                "claimName" = "tempo-claim1"
              }
            },
          ]
        }
      }
    }
  }
}
