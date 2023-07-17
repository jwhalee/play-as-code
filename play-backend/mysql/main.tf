resource "kubernetes_config_map_v1" "mysql-configmap" {
  metadata {
    name = "mysql-setup"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "mysql"
    }
  }

  data = {
    "setup.sh" = "${file("${path.module}/assets/setup.sh")}"
  }
}

resource "kubernetes_deployment" "deployment_mysql" {
  metadata {
      labels = {
        "io.kompose.service" = "mysql"
      }
      name = "mysql"
      namespace = var.namespace-prod
    }
  spec {
    replicas = 1
    strategy {}
    selector {
      match_labels = {
        "io.kompose.service" = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          "io.kompose.service" = "mysql"
        }
      }
      spec {
        container {
          args = [
            "mysqld",
            "--character-set-server=utf8mb4",
            "--collation-server=utf8mb4_unicode_ci",
            "--innodb_monitor_enable=all",
          ]
          env {
              name = "MYSQL_DATABASE"
              value = "grafana"
          }
          env {
              name = "MYSQL_PASSWORD"
              value = "89024jhk7D3809423hjhj"
            }
          env {
              name = "MYSQL_ROOT_PASSWORD"
              value = "89024jhk7D3809423hjhj"
            }
          env {
              name = "MYSQL_USER"
              value = "grafana"
            }
          image = "mysql:8.0.32"
          name = "mysql"
          port {
            container_port = 3306
            }
          resources {}
          volume_mount {
              mount_path = "/var/lib/mysql"
              name = "mysql-data"
          }
          volume_mount {
            mount_path = "/setup.sh"
            name = "mysql-setup"
            sub_path = "setup.sh"
          }
        }
        restart_policy = "Always"
        volume {
          name = "mysql-data"
          persistent_volume_claim {
            claim_name = "mysql-data"
          }
        }
        volume {
          name = "mysql-setup"
          config_map {
            name = "mysql-setup"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service_mysql" {
  metadata {
    labels = {
        "io.kompose.service" = "mysql"
      }
    name = "mysql"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
        "io.kompose.service" = "mysql"
      }
    port {
      name        = "3306"
      port        = 3306
      target_port = 3306
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
