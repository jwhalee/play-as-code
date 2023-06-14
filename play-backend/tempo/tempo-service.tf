resource "kubernetes_manifest" "service_tempo" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "tempo"
      }
      "name" = "tempo"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "14268"
          "port" = 14268
          "targetPort" = 14268
        },
        {
          "name" = "3200"
          "port" = 3200
          "targetPort" = 3200
        },
        {
          "name" = "4317"
          "port" = 4317
          "targetPort" = 4317
        },
        {
          "name" = "4318"
          "port" = 4318
          "targetPort" = 4318
        },
      ]
      "selector" = {
        "io.kompose.service" = "tempo"
      }
    }
  }
}
