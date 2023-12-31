resource "kubernetes_deployment" "deployment_elasticsearch" {
  metadata {
    name      = "elasticsearch"
    namespace = var.namespace-prod
    labels = {
      "io.kompose.service" = "elasticsearch"
    }
  }
  spec {
    strategy {}
    replicas = 1

    selector {
      match_labels = {
        "io.kompose.service" = "elasticsearch"
      }
    }

    template {
      metadata {
        labels = {
          "io.kompose.service" = "elasticsearch"
        }
      }
      spec {
        termination_grace_period_seconds = 300
        # service_account_name = "elasticsearch"

        # init_container {
        #   name              = "fix-the-volume-permission"
        #   image             = "busybox:latest"
        #   image_pull_policy = "IfNotPresent"
        #   command           = ["chown", "-R", "1000:1000", "/usr/share/elasticsearch/data"]
        #   security_context {
        #     privileged = true
        #   }
        #   volume_mount {
        #     name       = "elasticsearch-data"
        #     mount_path = "/usr/share/elasticsearch/data"
        #   }
        # }

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
          env {
            name  = "discovery.type"
            value = "single-node"
          }
          env {
            name  = "xpack.license.self_generated.type"
            value = "basic"
          }
          env {
            name  = "ELASTIC_PASSWORD"
            value = "grafana"
          }
          env {
            name  = "KIBANA_PASSWORD"
            value = "grafana"
          }
          env {
            name  = "xpack.security.enabled"
            value = "true"
          }
          env {
            name  = "ES_JAVA_OPTS"
            value = "-Xms4g -Xmx4g"
          }
          image = "elasticsearch:${var.elastic_version}"
          name  = "elasticsearch"
          port {
            container_port = 8086
          }
          resources {}
          # volume_mount {
          #   mount_path = "/usr/share/elasticsearch/data"
          #   name = "elasticsearch-data"
          # }
        }
        restart_policy = "Always"
        # volume {
        #   name = "elasticsearch-data"
        #   persistent_volume_claim {
        #     claim_name = "elasticsearch-data"
        #   }
        # }
      }
    }
  }
}

resource "kubernetes_service" "service_elasticsearch" {
  metadata {
    labels = {
      "io.kompose.service" = "elasticsearch"
    }
    name      = "elasticsearch"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      "io.kompose.service" = "elasticsearch"
    }
    port {
      name        = "9200"
      port        = 9200
      target_port = 9200
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_elastic" {
  metadata {
    name      = "elastic"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "elastic.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "elasticsearch"
              port {
                number = 9200
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "ingress_kibana" {
  metadata {
    name      = "kibana"
    namespace = var.namespace-prod
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "kibana.grafana.fun"
      http {
        path {
          path_type = "Prefix"
          path      = "/"
          backend {
            service {
              name = "kibana"
              port {
                number = 5601
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "kibana-configmap" {
  metadata {
    name      = "kibana-configmap"
    namespace = var.namespace-prod
  }

  data = {
    "kibana.yml" = "${file("${path.module}/assets/kibana.yml")}"
  }
}

resource "kubernetes_manifest" "deployment_kibana" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "kibana"
      }
      "name"      = "kibana"
      "namespace" = var.namespace-prod
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "kibana"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "labels" = {
            "io.kompose.service" = "kibana"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "docker.elastic.co/kibana/kibana:8.7.1"
              "name"  = "kibana"
              "ports" = [
                {
                  "containerPort" = 5601
                },
              ]
              "resources" = {}
              "volumeMounts" = [
                {
                  "mountPath" = "/usr/share/kibana/config/"
                  "name"      = "kibana-config"
                },
              ]
            },
          ]
          "restartPolicy" = "Always"
          "volumes" = [
            {
              "name" = "kibana-config"
              "configMap" = {
                "name" = "kibana-configmap"
              }
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "service_kibana" {
  metadata {
    labels = {
      "io.kompose.service" = "kibana"
    }
    name      = "kibana"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
      "io.kompose.service" = "kibana"
    }
    port {
      name        = "5601"
      port        = 5601
      target_port = 5601
    }
  }
}
