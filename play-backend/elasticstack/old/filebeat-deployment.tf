# resource "kubernetes_manifest" "deployment_filebeat" {
#   manifest = {
#     "apiVersion" = "apps/v1"
#     "kind" = "Deployment"
#     "metadata" = {
#       "labels" = {
#         "io.kompose.service" = "filebeat"
#       }
#       "name" = "filebeat"
#       namespace = var.namespace
#     }
#     "spec" = {
#       "replicas" = 1
#       "selector" = {
#         "matchLabels" = {
#           "io.kompose.service" = "filebeat"
#         }
#       }
#       "strategy" = {
#         "type" = "Recreate"
#       }
#       "template" = {
#         "metadata" = {
#           "labels" = {
#             "io.kompose.network/elasticstack-default" = "true"
#             "io.kompose.service" = "filebeat"
#           }
#         }
#         "spec" = {
#           "containers" = [
#             {
#               "args" = [
#                 "filebeat",
#                 "-e",
#                 "-strict.perms=false",
#               ]
#               "image" = "docker.elastic.co/beats/filebeat-oss:8.5.0"
#               "name" = "filebeat"
#               "resources" = {}
#               "volumeMounts" = [
#                 {
#                   "mountPath" = "/filebeat.yml"
#                   "name" = "filebeat-config"
#                   "readOnly" = true
#                 },
#                 # {
#                 #   "mountPath" = "/var/log/grafana"
#                 #   "name" = "filebeat-claim0"
#                 #   "readOnly" = true
#                 # },
#               ]
#             },
#           ]
#           "restartPolicy" = "Always"
#           "volumes" = [
#             {
#               "name" = "filebeat-config"
#               "configMap" = {
#                 "name" = "filebeat-configmap"
#               }
#             },
#             # {
#             #   "name" = "filebeat-claim0"
#             #   "persistentVolumeClaim" = {
#             #     "claimName" = "filebeat-claim0"
#             #     "readOnly" = true
#             #   }
#             # },
#           ]
#         }
#       }
#     }
#   }
# }
