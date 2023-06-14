# resource "kubernetes_persistent_volume_claim" "persistentvolumeclaim_filebeat_claim0" {
#   metadata {
#     name      = "filebeat-claim0"
#     namespace = var.namespace
#     labels = {
#       "io.kompose.service" = "filebeat-claim0"
#     }
#   }
#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "100mi"
#       }
#     }
#     storage_class_name = "standard"
#   }
# }
