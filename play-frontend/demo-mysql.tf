###############################################
##                                           ##
## MySQL datasource, folder, and dashboards  ##
##                                           ## 
###############################################

# provision datasource
resource "grafana_data_source" "play-ds-mysql-01" {
  provider = grafana.play

  type     = "mysql"
  name     = "MySQL 8: Cities of the World Data"
  url      = "34.133.99.59:3306"
  uid      = "QTzGEw97z"
  username = "grafanaReadOnly"
  json_data_encoded = jsonencode({
    database = "world_x",
  })
  secure_json_data_encoded = jsonencode({
    password = "${var.mysql-password}"
  })
}

# provision datasource
resource "grafana_data_source" "play-ds-mysql-02" {
  provider = grafana.play

  type     = "mysql"
  name     = "MySQL 8: Sakila Video Data"
  url      = "34.133.99.59:3306"
  uid      = "bo2ZeUr7k"
  username = "grafanaReadOnly"
  json_data_encoded = jsonencode({
    database = "sakila",
  })
  secure_json_data_encoded = jsonencode({
    password = "${var.mysql-password}"
  })
}

# provision folder
resource "grafana_folder" "play-folder-mysql" {
  provider = grafana.play
  uid      = "demo-mysql"
  title    = "Demo: MySQL 8"
}

# provision dashbaords
resource "grafana_dashboard" "mysql" {
  provider = grafana.play

  for_each    = fileset("${path.module}/dashboards/mysql", "*.json")
  config_json = file("${path.module}/dashboards/mysql/${each.key}")
  folder      = grafana_folder.play-folder-mysql.id
}