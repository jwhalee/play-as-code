resource "kubernetes_manifest" "service_loadgen" {
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
        "io.kompose.service" = "loadgen"
      }
      "name" = "loadgen"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "8002"
          "port" = 8002
          "targetPort" = 80
        },
      ]
      "selector" = {
        "io.kompose.service" = "loadgen"
      }
    }
  }
}
