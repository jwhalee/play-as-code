resource "kubernetes_manifest" "persistentvolumeclaim_tempo_claim1" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "tempo-claim1"
      }
      "name" = "tempo-claim1"
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
