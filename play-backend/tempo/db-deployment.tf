resource "kubernetes_manifest" "deployment_db" {
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
        "io.kompose.service" = "db"
      }
      "name" = "db"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "db"
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
            "io.kompose.service" = "db"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "-log.level=debug",
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
                  "value" = "job=tns/db"
                },
              ]
              "image" = "grafana/tns-db:9c1ab38"
              "name" = "db"
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
