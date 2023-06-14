resource "kubernetes_manifest" "service_prometheus" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
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
      "ports" = [
        {
          "name" = "9090"
          "port" = 9090
          "targetPort" = 9090
        },
      ]
      "selector" = {
        "io.kompose.service" = "prometheus"
      }
    }
  }
}
