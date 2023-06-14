# resource "kubernetes_config_map_v1" "metricbeat-configmap" {
#   metadata {
#     name = "metricbeat-configmap"
#     namespace = var.namespace
#   }

#   data = {
#     "metricbeat.yml" = "${file("${path.module}/assets/metricbeat.yml")}"
#   }
# }