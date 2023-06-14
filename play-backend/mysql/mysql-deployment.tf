resource "kubernetes_manifest" "deployment_mysql" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "mysql"
      }
      "name" = "mysql"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "mysql"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "labels" = {
            "io.kompose.network/mysql-default" = "true"
            "io.kompose.service" = "mysql"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "mysqld",
                "--character-set-server=utf8mb4",
                "--collation-server=utf8mb4_unicode_ci",
                "--innodb_monitor_enable=all",
              ]
              "env" = [
                {
                  "name" = "MYSQL_DATABASE"
                  "value" = "grafana"
                },
                {
                  "name" = "MYSQL_PASSWORD"
                  "value" = "password"
                },
                {
                  "name" = "MYSQL_ROOT_PASSWORD"
                  "value" = "rootpass"
                },
                {
                  "name" = "MYSQL_USER"
                  "value" = "grafana"
                },
              ]
              "image" = "mysql:8.0.32"
              "name" = "mysql"
              "ports" = [
                {
                  "containerPort" = 3306
                },
              ]
              "resources" = {}
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}
