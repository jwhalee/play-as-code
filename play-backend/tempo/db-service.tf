resource "kubernetes_manifest" "service_db" {
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
        "io.kompose.service" = "db"
      }
      "name" = "db"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "8000"
          "port" = 8000
          "targetPort" = 80
        },
      ]
      "selector" = {
        "io.kompose.service" = "db"
      }
    }
  }
}
