resource "kubernetes_manifest" "deployment_prometheus" {
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
        "io.kompose.service" = "prometheus"
      }
      "name" = "prometheus"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "prometheus"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "kompose.cmd" = "kompose convert"
            "kompose.version" = "1.28.0 (HEAD)"
            "namespace" = "monitoring"
          }
          "creationTimestamp" = null
          "labels" = {
            "io.kompose.network/tempo-default" = "true"
            "io.kompose.service" = "prometheus"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--config.file=/etc/prometheus.yaml",
                "--web.enable-remote-write-receiver",
                "--enable-feature=exemplar-storage",
              ]
              "image" = "prom/prometheus:latest"
              "name" = "prometheus"
              "ports" = [
                {
                  "containerPort" = 9090
                },
              ]
              "resources" = {}
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/prometheus.yaml"
                  "name" = "prometheus-claim0"
                },
              ]
            },
          ]
          "restartPolicy" = "Always"
          "volumes" = [
            {
              "name" = "prometheus-claim0"
              "persistentVolumeClaim" = {
                "claimName" = "prometheus-claim0"
              }
            },
          ]
        }
      }
    }
  }
}
