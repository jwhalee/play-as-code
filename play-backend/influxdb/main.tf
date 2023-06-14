# resource "kubernetes_deployment" "deployment_influxdb" {
#   metadata {
#     name = "influxdb"
#     namespace = var.namespace
#     labels = {
#       "io.kompose.service" = "influxdb"
#     }
#   }
#   spec {
#     strategy {
#         type = "Recreate"
#       }

#     replicas = 1

#     selector {
#       match_labels = {
#         "io.kompose.service" = "influxdb"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "io.kompose.service" = "influxdb"
#         }
#       }
#       spec {
#         container {
#           env { 
#               name = "DOCKER_INFLUXDB_INIT_ADMIN_TOKEN"
#               value = "mytoken"
#             }
#           env {
#               name = "DOCKER_INFLUXDB_INIT_BUCKET"
#               value = "mybucket"
#             }
#           env {
#               name = "DOCKER_INFLUXDB_INIT_MODE"
#               value = "setup"
#             }
#           env {
#               name = "DOCKER_INFLUXDB_INIT_ORG"
#               value = "myorg"
#             }
#           env {
#               name = "DOCKER_INFLUXDB_INIT_PASSWORD"
#               value = "grafana12345"
#             }
#           env {
#               name = "DOCKER_INFLUXDB_INIT_USERNAME"
#               value = "grafana"
#             }
#           env {
#             name = "INFLUXD_HTTP_BIND_ADDRESS"
#             value = ":8086"
#             }
#           env {
#             name = "INFLUXD_REPORTING_DISABLED"
#             value = "true"
#             }
#           image = "influxdb:${influxdb_version}"
#           name = "influxdb"
#           port {
#             container_port = 8086
#             }
#           resources {}
#           volume_mount {
#             mount_path = "/assets/setup.sh"
#             name = "influxdb-config"
#             sub_path = "setup.sh"
#           }
#           volume_mount {
#             mount_path = "/assets/noaa-buoys.flux"
#             name = "influxdb-config"
#             sub_path = "noaa-buoys.flux"
#           }
#           volume_mount {
#             mount_path = "/assets/noaa-water-sample.flux"
#             name = "influxdb-config"
#             sub_path = "noaa-water-sample.flux"
#           }
#           volume_mount {
#             mount_path = "/assets/usgs-earthquakes.flux"
#             name = "influxdb-config"
#             sub_path = "usgs-earthquakes.flux"
#           }
#           volume_mount {
#             mount_path = "/assets/influxdb.conf"
#             name = "influxdb-config"
#             sub_path = "influxdb.conf"
#           }
#         }
#         restart_policy = "Always"
#         volume {
#           name = "influxdb-config"
#           config_map {
#             name = "influxdb-configmap"
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "service_influxdb" {
#   metadata {
#     labels = {
#         "io.kompose.service" = "influxdb"
#       }
#     name = "influxdb"
#     namespace = var.namespace
#   }
#   spec {
#     selector = {
#         "io.kompose.service" = "influxdb"
#       }
#     port {
#       port        = 80
#       target_port = 8086
#       name        = "8086"
#     }
#     load_balancer_ip = var.play_influx_ip

#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_config_map_v1" "influxdb-configmap" {
#   metadata {
#     name = "influxdb-configmap"
#     namespace = var.namespace
#   }

#   data = {
#     "setup.sh" = "${file("${path.module}/assets/setup.sh")}"
#     "noaa-buoys.flux" = "${file("${path.module}/assets/noaa-buoys.flux")}"
#     "noaa-water-sample.flux" = "${file("${path.module}/assets/noaa-water-sample.flux")}"
#     "usgs-earthquakes.flux" = "${file("${path.module}/assets/usgs-earthquakes.flux")}"
#     "influxdb.conf" = "${file("${path.module}/assets/influxdb.conf")}"
#   }
# }
