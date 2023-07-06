###############################################
##                                           ##
## MySQL datasource, folder, and dashboards  ##
##                                           ## 
###############################################

variable "mysql-password" {}

# provision datasource
resource "grafana_data_source" "play-ds-mysql-01" {
  provider = grafana.play

  type          = "mysql"
  name          = "play-mysql-world"
  url           = "34.133.99.59:3306"
  uid           = "play-mysql-world"
  username      = "grafanaReadOnly"
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

  type          = "mysql"
  name          = "play-mysql-sakila"
  url           = "34.133.99.59:3306"
  uid           = "play-mysql-sakila"
  username      = "grafanaReadOnly"
  json_data_encoded = jsonencode({
    database = "sakila", 
  })
  secure_json_data_encoded = jsonencode({
    password = "${var.mysql-password}"
  })
}

# provision folder
# resource "grafana_folder" "play-folder-mysql" {
#   provider = grafana.play
#   uid   = "play-grafana-mysql"
#   title = "play-grafana-mysql"
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-mysql-01" {
  provider = grafana.play

  config_json = file("dashboards/mysql/mysql-sakila.json")
  folder = grafana_folder.play-grafana.id
}

output "play_dashboard_mysql_01" {
  value = resource.grafana_dashboard.play-dashboard-mysql-01
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-mysql-02" {
  provider = grafana.play

  config_json = file("dashboards/mysql/mysql-world-cities.json")
  folder = grafana_folder.play-grafana.id
}

output "play_dashboard_mysql_02" {
  value = resource.grafana_dashboard.play-dashboard-mysql-02
}