## lose this one

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_influxdb_claim0" {
  metadata {
    name      = "influxdb-claim0"
    namespace = var.namespace
    labels = {
      "io.kompose.service" = "influxdb-claim0"
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "standard"
  }
}