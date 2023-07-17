resource "kubernetes_deployment" "deployment_postgresdb" {
  metadata {
    name = "postgresdb"
    namespace = var.namespace-prod
    labels = {
      app = "postgresdb"
    }
  }
  spec {
    strategy {
        type = "Recreate"
      }

    replicas = 1

    selector {
      match_labels = {
        app = "postgresdb"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgresdb"
        }
      }
      spec {
        container {
          image = "postgres:${var.postgres_version}"
          name = "postgresdb"
          port {
            container_port = 5432
            }
          resources {}
          env_from {
            config_map_ref {
              name = "postgresdb-configmap"
            }
          }
          # volume_mount {
          #   mount_path = "/var/lib/postgres/data"
          #   name = "postgresdb-claim0"
          # }
        }
        restart_policy = "Always"
        volume {
          name = "postgresdb-volume"
          config_map {
            name = "postgresdb-configmap"
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "postgresdb-configmap" {
  metadata {
    name = "postgresdb-configmap"
    namespace = var.namespace-prod
    # labels = {
    #   app = "postgresdb"
    # }
  }

  data = {
    # User DB
    POSTGRES_DB = "testDB"
    # Db user
    POSTGRES_USER = "testUser"
    # Db password
    POSTGRES_PASSWORD = "testPassword"
  }
}

resource "kubernetes_service" "service_postgresdb" {
  metadata {
    labels = {
        app = "postgresdb"
      }
    name = "postgresdb"
    namespace = var.namespace-prod
  }
  spec {
    selector = {
        app = "postgresdb"
      }
    port {
      name        = "5432"
      port        = 80
      target_port = 5432
    }
    load_balancer_ip = var.cluster_ip

    type = "LoadBalancer"
  }
}
