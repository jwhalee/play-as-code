resource "kubernetes_daemon_set_v1" "daemon_set_elastic_agent" {
  metadata {
    name      = "elastic-agent"
    namespace = "kube-system"
    labels = {
      app = "elastic-agent"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "elastic-agent"
      }
    }

    template {
      metadata {
        labels = {
          app = "elastic-agent"
        }
      }

      spec {
        toleration {
          key = "node-role.kubernetes.io/control-plane"
          effect = "NoSchedule"
        }
        toleration {
          key = "node-role.kubernetes.io/master"
          effect = "NoSchedule"
        }
        service_account_name = "elastic-agent"
        host_network = "true"
        dns_policy = "ClusterFirstWithHostNet"

        container {
          image = "docker.elastic.co/beats/elastic-agent:8.7.1"
          name  = "elastic-agent"
          args = [ "-c", "/etc/elastic-agent/agent.yml", "-e",]
          env {
            name = "ES_USERNAME"
            value = "elastic"
          }
          env {
            name = "ES_PASSWORD"
            value = "grafana"
          }
          env {
            name = "NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }
          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }
          env {
            name = "STATE_PATH"
            value = "/etc/elastic-agent"
          }
          security_context {
            run_as_user = 0
          }
          resources {
            limits = {
              memory = "700Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "400Mi"
            }
          }
          volume_mount {
            name = "datastreams"
            mount_path = "/etc/elastic-agent/agent.yml"
            read_only = true
            sub_path = "agent.yml"
          }
          volume_mount {
            name = "proc"
            mount_path = "/hostfs/proc"
            read_only = true
          }
          volume_mount {
            name = "cgroup"
            mount_path = "/hostfs/sys/fs/cgroup"
            read_only = true            
          }
          volume_mount {
            name = "varlibdockercontainers"
            mount_path = "/var/lib/docker/containers"
            read_only = true              
          }
          volume_mount {
            name = "varlog"
            mount_path = "/var/log"
            read_only = true             
          }
        #   volume_mount {
        #     name = "etc-full"
        #     mount_path = "/hostfs/etc"
        #     read_only = true             
        #   }
        #   volume_mount {
        #     name = "var-lib"
        #     mount_path = "/hostfs/var/lib"
        #     read_only = true             
        #   }
        }
        volume {
          name = "datastreams"
          config_map {
            default_mode = "00640"
            name = "agent-node-datastreams"
          }
        }
        volume {
          name = "proc"
          host_path {
            path = "/proc"
          }
        }
        volume {
          name = "cgroup"
          host_path {
            path = "/sys/fs/cgroup"
          }
        }
        volume {
          name = "varlibdockercontainers"
          host_path {
            path = "/var/lib/docker/containers"
          }
        }
        volume {
          name = "varlog"
          host_path {
            path = "/var/log"
          }
        }
      }
    }
  }
}
