resource "kubernetes_manifest" "deployment_fake_mysql_data" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "io.kompose.service" = "fake-mysql-data"
      }
      "name" = "fake-mysql-data"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "io.kompose.service" = "fake-mysql-data"
        }
      }
      "strategy" = {}
      "template" = {
        "metadata" = {
          "labels" = {
            "io.kompose.network/mysql-default" = "true"
            "io.kompose.service" = "fake-mysql-data"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "FD_DATASOURCE"
                  "value" = "mysql"
                },
                {
                  "name" = "FD_PORT"
                  "value" = "3306"
                },
                {
                  "name" = "FD_SERVER"
                  "value" = "mysql"
                },
              ]
              "image" = "grafana/fake-data-gen"
              "name" = "fake-mysql-data"
              "resources" = {}
            },
          ]
          "restartPolicy" = "Always"
        }
      }
    }
  }
}
