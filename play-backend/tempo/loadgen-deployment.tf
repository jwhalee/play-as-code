resource "kubernetes_manifest" "deployment_loadgen" {
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
        "io.kompose.service" = "loadgen"
      }
      "name" = "loadgen"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "loadgen"
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
            "io.kompose.service" = "loadgen"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "-log.level=debug",
                "http://app",
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
                  "value" = "job=tns/loadgen"
                },
              ]
              "image" = "grafana/tns-loadgen:9c1ab38"
              "name" = "loadgen"
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
