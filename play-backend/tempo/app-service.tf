resource "kubernetes_manifest" "service_app" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
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
      "ports" = [
        {
          "name" = "8001"
          "port" = 8001
          "targetPort" = 80
        },
      ]
      "selector" = {
        "io.kompose.service" = "app"
      }
    }
  }
}
