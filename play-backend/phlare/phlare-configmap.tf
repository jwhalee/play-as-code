resource "kubernetes_config_map_v1" "phlare-configmap" {
  metadata {
    name = "phlare-configmap"
    namespace = var.namespace
  }

  data = {
    "phlare.yaml" = "${file("${path.module}/assets/phlare.yaml")}"
  }
}