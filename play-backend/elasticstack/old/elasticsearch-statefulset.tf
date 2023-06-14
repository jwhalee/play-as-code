resource "kubernetes_stateful_set_v1" "elasticsearch" {
  metadata {
    name = "elasticsearch"
    namespace = var.namespace
    labels = {
      service = "elasticsearch"
    }
  }

  spec {
    service_name = "elasticsearch"
    # pod_management_policy  = "Parallel"
    replicas               = 2
    # revision_history_limit = 5

    selector {
      match_labels = {
        service = "elasticsearch"
      }
    }

    template {
      metadata {
        labels = {
          service = "elasticsearch"
        }
      }
      spec {
        termination_grace_period_seconds = 300
        # service_account_name = "elasticsearch"

        init_container {
          name              = "fix-the-volume-permission"
          image             = "busybox:latest"
          image_pull_policy = "IfNotPresent"
          command           = ["chown", "-R", "1000:1000", "/usr/share/elasticsearch/data"]
          security_context {
            privileged = true
          }
          volume_mount {
            name       = "elasticsearch-data"
            mount_path = "/usr/share/elasticsearch/data"
          }
        }

        init_container {
          name              = "increase-the-vm-max-map-count"
          image             = "busybox:latest"
          image_pull_policy = "IfNotPresent"
          command           = ["sysctl", "-w", "vm.max_map_count=262144"]
          security_context {
            privileged = true
          }
        }

        init_container {
          name              = "increase-the-ulimit"
          image             = "busybox:latest"
          image_pull_policy = "IfNotPresent"
          command           = ["sh", "-c", "ulimit -n 65536"]
          security_context {
            privileged = true
          }
        }

        container {
          name              = "elasticsearch"
          image             = "docker.elastic.co/elasticsearch/elasticsearch:8.7.1"
          image_pull_policy = "IfNotPresent"
          
        #   env {
        #     name = cluster.name
        #     value = "elasticsearch-cluster"
        #   }

          env {
            name = "node.name"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "ES_JAVA_OPTS"
            value = "-Xms4g -Xmx4g"
          }

          env {
            name = "discovery.type"
            value = "single-node"
          }

          env {
            name = "xpack.license.self_generated.type"
            value = "basic"
          }

          env {
            name = "ELASTIC_PASSWORD"
            value = "grafana"
          }

          env {
            name = "KIBANA_PASSWORD"
            value = "grafana"
          }

          env {
            name = "xpack.security.enabled"
            value = "true"
          }

          port {
            container_port = 9200
            name = "http"
          }

          port {
            container_port = 9300
            name = "tcp"
          }

          volume_mount {
            name       = "elasticsearch-data"
            mount_path = "/usr/share/elasticsearch/data"
          }

          resources {
            limits = {
              memory = "5Gi"
            }
            requests = {
              memory = "2Gi"
            }
          }
        }
      }
    }
    update_strategy {
      type = "RollingUpdate"

      rolling_update {
        partition = 1
      }
    }

    volume_claim_template {
      metadata {
        name = "elasticsearch-data"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = "standard"

        resources {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }
  }
}
