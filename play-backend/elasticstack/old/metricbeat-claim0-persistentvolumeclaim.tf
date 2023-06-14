# resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_metricbeat_claim0" {
#   metadata {
#     name      = "metricbeat-claim0"
#     namespace = var.namespace
#     labels = {
#       "io.kompose.service" = "metricbeat-claim0"
#     }
#   }
#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "1Gi"
#       }
#     }
#     storage_class_name = "standard"
#   }
# }