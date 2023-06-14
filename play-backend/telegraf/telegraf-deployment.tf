resource "kubernetes_manifest" "deployment_telegraf_deployment" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = "telegraf-deployment"
      "namespace" = var.namespace
    }
    "spec" = {
      "minReadySeconds" = 5
      "selector" = {
        "matchLabels" = {
          "app" = "telegraf"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "telegraf"
          }
        }
        "spec" = {
          "containers" = [
            {
              # "envFrom" = [
              #   {
              #     "secretRef" = {
              #       "name" = "telegraf-secrets"
              #     }
              #   },
              # ]
              "image" = "telegraf:${var.telegraf_version}"
              "name" = "telegraf"
              "volumeMounts" = [
                {
                  "mountPath" = "/etc/telegraf/telegraf.conf"
                  "name" = "telegraf-config"
                  "readOnly" = true
                  "subPath" = "telegraf.conf"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "configMap" = {
                "name" = "telegraf-config"
              }
              "name" = "telegraf-config"
            },
          ]
        }
      }
    }
  }
}
