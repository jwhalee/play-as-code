# resource "kubernetes_deployment" "deployment_metricbeat" {
#   metadata {
#     name = "metricbeat"
#     namespace = var.namespace
#     labels = {
#       "io.kompose.service" = "metricbeat"
#     }
#   }
#   spec {
#     strategy {
#         type = "Recreate"
#       }

#     replicas = 1

#     selector {
#       match_labels = {
#         "io.kompose.service" = "metricbeat"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "io.kompose.service" = "metricbeat"
#         }
#       }
#       spec {
#         container {
#         #   command = [ "metricbeat" ]
#         #   args = ["-c", "/etc/metricbeat.yml", "-e", "-system.hostfs=/hostfs"]
#           env { 
#               name = "ELASTICSEARCH_HOSTS"
#               value = "https://elastic.grafana.fun"
#             }
#           env { 
#               name = "ELASTICSEARCH_USERNAME"
#               value = "elastic"
#             }
#           env { 
#               name = "ELASTICSEARCH_PASSWORD"
#               value = "grafana"
#             }
#           image = "docker.elastic.co/beats/metricbeat-oss:8.5.0"
#           name = "metricbeat"
#           resources {}
#           volume_mount {
#             mount_path = "/etc/metricbeat"
#             name = "metricbeat-config"
#             sub_path = "metricbeat.yml"
#           }
#         }
#         restart_policy = "Always"
#         volume {
#           name = "metricbeat-config"
#           config_map {
#             name = "metricbeat-configmap"
#           }
#         }
#       }
#     }
#   }
# }


# # resource "kubernetes_manifest" "deployment_metricbeat" {
# #   manifest = {
# #     "apiVersion" = "apps/v1"
# #     "kind" = "Deployment"
# #     "metadata" = {
# #       "labels" = {
# #         "io.kompose.service" = "metricbeat"
# #       }
# #       "name" = "metricbeat"
# #       namespace = var.namespace
# #     }
# #     "spec" = {
# #       "replicas" = 1
# #       "selector" = {
# #         "matchLabels" = {
# #           "io.kompose.service" = "metricbeat"
# #         }
# #       }
# #       "strategy" = {
# #         "type" = "Recreate"
# #       }
# #       "template" = {
# #         "metadata" = {
# #           "labels" = {
# #             "io.kompose.network/elasticstack-default" = "true"
# #             "io.kompose.service" = "metricbeat"
# #           }
# #         }
# #         "spec" = {
# #           "containers" = [
# #             {
# #               # "args" = [
# #                 # "-c", "/etc/metricbeat.yml",
# #                 # "-e",
# #                 # "-system.hostfs=/hostfs",
# #               # ]
# #               "image" = "docker.elastic.co/beats/metricbeat-oss:8.5.0"
# #               "name" = "metricbeat"
# #               "resources" = {}
# #               "volumeMounts" = [
# #                 {
# #                   "mountPath" = "/usr/share/metricbeat/metricbeat.yml"
# #                   "name" = "metricbeat-config"
# #                 },
# #                 # {
# #                 #   "mountPath" = "/var/run/docker.sock"
# #                 #   "name" = "metricbeat-claim0"
# #                 #   "readOnly" = true
# #                 # },
# #               ]
# #             },
# #           ]
# #           "restartPolicy" = "Always"
# #           "volumes" = [
# #             {
# #               "name" = "metricbeat-config"
# #               "configMap" = {
# #                 "name" = "metricbeat-configmap"
# #               }
# #             },
# #             # {
# #             #   "name" = "metricbeat-claim0"
# #             #   "persistentVolumeClaim" = {
# #             #     "claimName" = "metricbeat-claim0"
# #             #     "readOnly" = true
# #             #   }
# #             # },
# #           ]
# #         }
# #       }
# #     }
# #   }
# # }
