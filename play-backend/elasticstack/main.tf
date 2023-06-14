# resource "kubernetes_deployment" "deployment_elasticsearch" {
#   metadata {
#     name = "elasticsearch"
#     namespace = var.namespace
#     labels = {
#       "io.kompose.service" = "elasticsearch"
#     }
#   }
#   spec {
#     strategy {}
#     replicas = 1

#     selector {
#       match_labels = {
#         "io.kompose.service" = "elasticsearch"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "io.kompose.service" = "elasticsearch"
#         }
#       }
#       spec {
#         termination_grace_period_seconds = 300
#         # service_account_name = "elasticsearch"

#         init_container {
#           name              = "fix-the-volume-permission"
#           image             = "busybox:latest"
#           image_pull_policy = "IfNotPresent"
#           command           = ["chown", "-R", "1000:1000", "/usr/share/elasticsearch/data"]
#           security_context {
#             privileged = true
#           }
#           volume_mount {
#             name       = "elasticsearch-data"
#             mount_path = "/usr/share/elasticsearch/data"
#           }
#         }

#         init_container {
#           name              = "increase-the-vm-max-map-count"
#           image             = "busybox:latest"
#           image_pull_policy = "IfNotPresent"
#           command           = ["sysctl", "-w", "vm.max_map_count=262144"]
#           security_context {
#             privileged = true
#           }
#         }

#         init_container {
#           name              = "increase-the-ulimit"
#           image             = "busybox:latest"
#           image_pull_policy = "IfNotPresent"
#           command           = ["sh", "-c", "ulimit -n 65536"]
#           security_context {
#             privileged = true
#           }
#         }

#         container {
#           env { 
#               name = "discovery.type"
#               value = "single-node"
#             }
#           env {
#               name = "xpack.license.self_generated.type"
#               value = "basic"
#             }
#           env {
#               name = "ELASTIC_PASSWORD"
#               value = "grafana"
#             }
#           # env {
#           #     name = "KIBANA_PASSWORD"
#           #     value = "grafana"
#           #   }
#           env {
#               name = "xpack.security.enabled"
#               value = "true"
#             }
#           env {
#             name = "ES_JAVA_OPTS"
#             value = "-Xms4g -Xmx4g"
#           }
#           image = "elasticsearch:${elastic_version}"
#           name = "elasticsearch"
#           port {
#             container_port = 8086
#             }
#           resources {}
#           # volume_mount {
#           #   mount_path = "/usr/share/elasticsearch/data"
#           #   name = "elasticsearch-data"
#           # }
#         }
#         restart_policy = "Always"
#         # volume {
#         #   name = "elasticsearch-data"
#         #   persistent_volume_claim {
#         #     claim_name = "elasticsearch-data"
#         #   }
#         # }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "service_elasticsearch" {
#   metadata {
#     labels = {
#         "io.kompose.service" = "elasticsearch"
#       }
#     name = "elasticsearch"
#     namespace = var.namespace
#   }
#   spec {
#     selector = {
#         "io.kompose.service" = "elasticsearch"
#       }
#     port {
#       name = "9200"
#       port        = 80
#       target_port = 9200
#     }
#     load_balancer_ip = var.play_elastic_ip

#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_config_map_v1" "kibana-configmap" {
#   metadata {
#     name = "kibana-configmap"
#     namespace = var.namespace
#   }

#   data = {
#     "kibana.yml" = "${file("${path.module}/assets/kibana.yml")}"
#   }
# }

# resource "kubernetes_manifest" "deployment_kibana" {
#   manifest = {
#     "apiVersion" = "apps/v1"
#     "kind" = "Deployment"
#     "metadata" = {
#       "labels" = {
#         "io.kompose.service" = "kibana"
#       }
#       "name" = "kibana"
#       "namespace" = "matt-sandbox"
#     }
#     "spec" = {
#       "replicas" = 1
#       "selector" = {
#         "matchLabels" = {
#           "io.kompose.service" = "kibana"
#         }
#       }
#       "strategy" = {}
#       "template" = {
#         "metadata" = {
#           "labels" = {
#             "io.kompose.service" = "kibana"
#           }
#         }
#         "spec" = {
#           "containers" = [
#             {
#               "image" = "docker.elastic.co/kibana/kibana:8.7.1"
#               "name" = "kibana"
#               "ports" = [
#                 {
#                   "containerPort" = 5601
#                 },
#               ]
#               "resources" = {}
#               "volumeMounts" = [
#                 {
#                   "mountPath" = "/usr/share/kibana/config/"
#                   "name" = "kibana-config"
#                 },
#               ]
#             },
#           ]
#           "restartPolicy" = "Always"
#           "volumes" = [
#             {
#               "name" = "kibana-config"
#               "configMap" = {
#                 "name" = "kibana-configmap"
#               }
#             },
#           ]
#           "restartPolicy" = "Always"
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "service_kibana" {
#   metadata {
#     labels = {
#         "io.kompose.service" = "kibana"
#       }
#     name = "kibana"
#     namespace = var.namespace
#   }
#   spec {
#     selector = {
#         "io.kompose.service" = "kibana"
#       }
#     port {
#       name = "5601"
#       port        = 80
#       target_port = 5601
#     }
#     load_balancer_ip = var.play_kibana_ip

#     type = "LoadBalancer"
#   }
# }

# resource "kubernetes_service_account_v1" "service_account_elastic_agent" {
#   metadata {
#     name = "elastic-agent"
#     namespace = "kube-system"
#     labels = {
#       "k8s-app" = "elastic-agent"
#     }
#   }
# }

# resource "kubernetes_daemon_set_v1" "daemon_set_elastic_agent" {
#   metadata {
#     name      = "elastic-agent"
#     namespace = "kube-system"
#     labels = {
#       app = "elastic-agent"
#     }
#   }

#   spec {
#     selector {
#       match_labels = {
#         app = "elastic-agent"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "elastic-agent"
#         }
#       }

#       spec {
#         toleration {
#           key = "node-role.kubernetes.io/control-plane"
#           effect = "NoSchedule"
#         }
#         toleration {
#           key = "node-role.kubernetes.io/master"
#           effect = "NoSchedule"
#         }
#         service_account_name = "elastic-agent"
#         host_network = "true"
#         dns_policy = "ClusterFirstWithHostNet"

#         container {
#           image = "docker.elastic.co/beats/elastic-agent:8.7.1"
#           name  = "elastic-agent"
#           args = [ "-c", "/etc/elastic-agent/agent.yml", "-e",]
#           env {
#             name = "ES_USERNAME"
#             value = "elastic"
#           }
#           env {
#             name = "ES_PASSWORD"
#             value = "grafana"
#           }
#           env {
#             name = "NODE_NAME"
#             value_from {
#               field_ref {
#                 field_path = "spec.nodeName"
#               }
#             }
#           }
#           env {
#             name = "POD_NAME"
#             value_from {
#               field_ref {
#                 field_path = "metadata.name"
#               }
#             }
#           }
#           env {
#             name = "STATE_PATH"
#             value = "/etc/elastic-agent"
#           }
#           security_context {
#             run_as_user = 0
#           }
#           resources {
#             limits = {
#               memory = "700Mi"
#             }
#             requests = {
#               cpu    = "100m"
#               memory = "400Mi"
#             }
#           }
#           volume_mount {
#             name = "datastreams"
#             mount_path = "/etc/elastic-agent/agent.yml"
#             read_only = true
#             sub_path = "agent.yml"
#           }
#           volume_mount {
#             name = "proc"
#             mount_path = "/hostfs/proc"
#             read_only = true
#           }
#           volume_mount {
#             name = "cgroup"
#             mount_path = "/hostfs/sys/fs/cgroup"
#             read_only = true            
#           }
#           volume_mount {
#             name = "varlibdockercontainers"
#             mount_path = "/var/lib/docker/containers"
#             read_only = true              
#           }
#           volume_mount {
#             name = "varlog"
#             mount_path = "/var/log"
#             read_only = true             
#           }
#         #   volume_mount {
#         #     name = "etc-full"
#         #     mount_path = "/hostfs/etc"
#         #     read_only = true             
#         #   }
#         #   volume_mount {
#         #     name = "var-lib"
#         #     mount_path = "/hostfs/var/lib"
#         #     read_only = true             
#         #   }
#         }
#         volume {
#           name = "datastreams"
#           config_map {
#             default_mode = "00640"
#             name = "agent-node-datastreams"
#           }
#         }
#         volume {
#           name = "proc"
#           host_path {
#             path = "/proc"
#           }
#         }
#         volume {
#           name = "cgroup"
#           host_path {
#             path = "/sys/fs/cgroup"
#           }
#         }
#         volume {
#           name = "varlibdockercontainers"
#           host_path {
#             path = "/var/lib/docker/containers"
#           }
#         }
#         volume {
#           name = "varlog"
#           host_path {
#             path = "/var/log"
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_config_map_v1" "elastic-agent-configmap" {
#   metadata {
#     name = "agent-node-datastreams"
#     namespace = "kube-system"
#     labels = {
#       "k8s-app" = "elastic-agent"
#     }
#   }

#   data = {
#     "agent.yml" = "${file("${path.module}/assets/agent.yml")}"
#   }
# }
