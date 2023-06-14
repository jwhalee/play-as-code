resource "kubernetes_manifest" "deployment_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "kompose.cmd" = "kompose convert"
        "kompose.version" = "1.28.0 (HEAD)"
        "namespace" = "tns"
      }
      "labels" = {
        "io.kompose.service" = "app"
      }
      "name" = "app"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "app"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "annotations" = {
            "kompose.cmd" = "kompose convert"
            "kompose.version" = "1.28.0 (HEAD)"
            "namespace" = "tns"
          }
          "labels" = {
            "io.kompose.network/tempo-default" = "true"
            "io.kompose.service" = "app"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "-log.level=debug",
                "http://db",
              ]
              "env" = [
                {
                  "name" = "JAEGER_ENDPOINT"
                  "value" = "http://tempo:14268/api/traces"
                },
                {
                  "name" = "JAEGER_SAMPLER_PARAM"
                  "value" = "1"
                },
                {
                  "name" = "JAEGER_SAMPLER_TYPE"
                  "value" = "const"
                },
                {
                  "name" = "JAEGER_TAGS"
                  "value" = "job=tns/app"
                },
              ]
              "image" = "grafana/tns-app:9c1ab38"
              "name" = "app"
              "ports" = [
                {
                  "containerPort" = 80
                  "hostIP" = "0.0.0.0"
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
