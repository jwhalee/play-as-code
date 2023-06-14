resource "kubernetes_manifest" "persistentvolumeclaim_prometheus_claim0" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "prometheus-claim0"
      }
      "name" = "prometheus-claim0"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "resources" = {
        "requests" = {
          "storage" = "100Mi"
        }
      }
    }
  }
}
