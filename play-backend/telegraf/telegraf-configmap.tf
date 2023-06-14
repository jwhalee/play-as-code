resource "kubernetes_config_map_v1" "telegraf-config" {
  metadata {
    name = "telegraf-config"
    namespace = var.namespace
  }

  data = {
    "telegraf.conf" = "${file("${path.module}/assets/telegraf.conf")}"
  }
}