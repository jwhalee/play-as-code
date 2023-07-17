resource "kubernetes_manifest" "deployment_kibana" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "kibana"
      }
      "name" = "kibana"
      "namespace" = var.namespace-prod
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "kibana"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "labels" = {
            "io.kompose.service" = "kibana"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "docker.elastic.co/kibana/kibana:8.7.1"
              "name" = "kibana"
              "ports" = [
                {
                  "containerPort" = 5601
                },
              ]
              "resources" = {}
              "volumeMounts" = [
                {
                  "mountPath" = "/usr/share/kibana/config/"
                  "name" = "kibana-config"
                },
              ]
            },
          ]
          "restartPolicy" = "Always"
          "volumes" = [
            {
              "name" = "kibana-config"
              "configMap" = {
                "name" = "kibana-configmap"
              }
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}
