resource "kubernetes_manifest" "persistentvolumeclaim_tempo_claim0" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "tempo-claim0"
      }
      "name" = "tempo-claim0"
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
