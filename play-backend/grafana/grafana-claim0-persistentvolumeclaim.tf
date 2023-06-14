## lose this

resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_grafana_claim0" {
  metadata {
    name      = "grafana-claim0"
    namespace = var.namespace
    labels = {
      "io.kompose.service" = "grafana-claim0"
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
