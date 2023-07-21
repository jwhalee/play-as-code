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

# provision dashboard
resource "grafana_dashboard" "play-dashboard-mysql-01" {
  provider = grafana.play

  config_json = file("dashboards/mysql/mysql-sakila.json")
  folder      = grafana_folder.play-folder-mysql.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-mysql-02" {
  provider = grafana.play

  config_json = file("dashboards/mysql/mysql-world-cities.json")
  folder      = grafana_folder.play-folder-mysql.id
}

# output "play_dashboard_mysql_02" {
#   value = resource.grafana_dashboard.play-dashboard-mysql-02
# }

# output "play_dashboard_mysql_01" {
#   value = resource.grafana_dashboard.play-dashboard-mysql-01
# }