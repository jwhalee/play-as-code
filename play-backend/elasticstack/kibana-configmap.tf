resource "kubernetes_config_map_v1" "kibana-configmap" {
  metadata {
    name = "kibana-configmap"
    namespace = var.namespace-prod
  }

  data = {
    "kibana.yml" = "${file("${path.module}/assets/kibana.yml")}"
  }
}