###############################################
##                                           ##
## INFLUX datasource, folder, and dashboards ##
##                                           ## 
###############################################

variable "influx-token" {}

# provision datasource
resource "grafana_data_source" "play-ds-influx" {
  provider = grafana.play

  type          = "influxdb"
  name          = "play-influx"
  url           = "https://influxdb.grafana.fun"
  uid           = "play-influx"
  json_data_encoded = jsonencode({
    defaultBucket = "_monitoring", 
    httpMode      = "POST", 
    organization  = "grafana", 
    version       = "Flux"
  })
  secure_json_data_encoded = jsonencode({
    token = "${var.influx-token}"
  })
}

output "play_ds_influx" {
  sensitive = true
  value = resource.grafana_data_source.play-ds-influx
}

# provision folder
resource "grafana_folder" "play-folder-influx" {
  provider = grafana.play

  title = "influxDB"
}

output "play_folder_influx" {
  value = resource.grafana_folder.play-folder-influx
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-01" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-noaa-buoys.json")
  folder = grafana_folder.play-folder-influx.id
}

output "play_dashboard_influx_01" {
  type = "string"
  value = resource.grafana_dashboard.play-dashboard-influx-01
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-02" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-usgs-earthquakes.json")
  folder = grafana_folder.play-folder-influx.id
}
output "play_dashboard_influx_02" {
  type = "string"
  value = resource.grafana_dashboard.play-dashboard-influx-02
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-03" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-water-samples.json")
  folder = grafana_folder.play-folder-influx.id
}
output "play_dashboard_influx_03" {
  value = resource.grafana_dashboard.play-dashboard-influx-03
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-04" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-internal-metrics.json")
  folder = grafana_folder.play-folder-influx.id
}
output "play_dashboard_influx_04" {
  value = resource.grafana_dashboard.play-dashboard-influx-04
}