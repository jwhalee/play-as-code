# resource "kubernetes_config_map_v1" "filebeat-configmap" {
#   metadata {
#     name = "filebeat-configmap"
#     namespace = var.namespace
#   }

#   data = {
#     "filebeat.yml" = "${file("${path.module}/assets/filebeat.yml")}"
#   }
# }