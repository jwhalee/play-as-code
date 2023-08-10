resource "kubernetes_deployment" "deployment_influxdb" {
  metadata {
    name = "influxdb"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "influxdb"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "influxdb"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "influxdb"
        }
      }
      spec {
        container {
          env { 
              name = "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN"
              value = "ccTQ6pZiZJiCtRkmjgck"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_BUCKET"
              value = "grafana"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_MODE"
              value = "setup"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_ORG"
              value = "grafana"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_PASSWORD"
              value = "grafana12345"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_USERNAME"
              value = "grafana"
            }
          env {
            name = "INFLUXD_HTTP_BIND_ADDRESS"
            value = ":8086"
            }
          env {
            name = "INFLUXD_REPORTING_DISABLED"
            value = "true"
            }
          image = "influxdb:${var.influxdb_version}"
          name = "influxdb"
          port {
            container_port = 8086
            }
          resources {}
          volume_mount {
              mount_path = "/var/lib/influxdb2"
              name = "influx-data"
          }
          volume_mount {
            mount_path = "/scripts/setup.sh"
            name = "influxdb-config"
            sub_path = "setup.sh"
          }
          volume_mount {
            mount_path = "/scripts/noaa-buoys.flux"
            name = "influxdb-config"
            sub_path = "noaa-buoys.flux"
          }
          volume_mount {
            mount_path = "/scripts/noaa-water-sample.flux"
            name = "influxdb-config"
            sub_path = "noaa-water-sample.flux"
          }
          volume_mount {
            mount_path = "/scripts/usgs-earthquakes.flux"
            name = "influxdb-config"
            sub_path = "usgs-earthquakes.flux"
          }
          volume_mount {
            mount_path = "/influxdb.conf"
            name = "influxdb-config"
            sub_path = "influxdb.conf"
          }
        }
        restart_policy = "Always"
        volume {
          name = "influx-data"
          persistent_volume_claim {
            claim_name = "influx-data"
          }
        }
        volume {
          name = "influxdb-config"
          config_map {
            name = "influxdb-configmap"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_influxdb" {
  metadata {
    labels = {
        "io.kompose.service" = "influxdb"
      }
    name = "influxdb"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
        "io.kompose.service" = "influxdb"
      }
    port {
      port        = 8086
      target_port = 8086
      name        = "8086"
    }
  }
}

resource "kubernetes_config_map_v1" "influxdb-configmap" {
  metadata {
    name = "influxdb-configmap"
    namespace = var.namespace-prod
  }

  data = {
    "noaa-buoys.flux" = "${file("${path.module}/assets/noaa-buoys.flux")}"
    "noaa-water-sample.flux" = "${file("${path.module}/assets/noaa-water-sample.flux")}"
    "usgs-earthquakes.flux" = "${file("${path.module}/assets/usgs-earthquakes.flux")}"
    "influxdb.conf" = "${file("${path.module}/assets/influxdb.conf")}"
    "setup.sh" = "${file("${path.module}/assets/setup.sh")}"
  }
}

resource "kubernetes_ingress_v1" "ingress_influx" {
  metadata {
    name = "influxdb"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "influx.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path = "/"
          backend {
            service {
              name = "influxdb"
              port {
                number = 8086
              }
            }
          }
        }   
      }
    }
  }
}