resource "kubernetes_deployment" "deployment_influxdb" {
  metadata {
    name = "influxdb"
    namespace = var.namespace
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
              value = "mytoken"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_BUCKET"
              value = "mybucket"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_MODE"
              value = "setup"
            }
          env {
              name = "DOCKER_INFLUXDB_INIT_ORG"
              value = "myorg"
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
            mount_path = "/assets/setup.sh"
            name = "influxdb-config"
            sub_path = "setup.sh"
          }
          volume_mount {
            mount_path = "/assets/noaa-buoys.flux"
            name = "influxdb-config"
            sub_path = "noaa-buoys.flux"
          }
          volume_mount {
            mount_path = "/assets/noaa-water-sample.flux"
            name = "influxdb-config"
            sub_path = "noaa-water-sample.flux"
          }
          volume_mount {
            mount_path = "/assets/usgs-earthquakes.flux"
            name = "influxdb-config"
            sub_path = "usgs-earthquakes.flux"
          }
          volume_mount {
            mount_path = "/assets/influxdb.conf"
            name = "influxdb-config"
            sub_path = "influxdb.conf"
          }
        }
        restart_policy = "Always"
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
