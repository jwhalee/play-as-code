resource "kubernetes_config_map_v1" "influxdb-configmap" {
  metadata {
    name = "influxdb-configmap"
    namespace = var.namespace
  }

  data = {
    "setup.sh" = "${file("${path.module}/assets/setup.sh")}"
    "noaa-buoys.flux" = "${file("${path.module}/assets/noaa-buoys.flux")}"
    "noaa-water-sample.flux" = "${file("${path.module}/assets/noaa-water-sample.flux")}"
    "usgs-earthquakes.flux" = "${file("${path.module}/assets/usgs-earthquakes.flux")}"
    "influxdb.conf" = "${file("${path.module}/assets/influxdb.conf")}"
  }
}