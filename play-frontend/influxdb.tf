###############################################
##                                           ##
## INFLUX datasource, folder, and dashboards ##
##                                           ## 
###############################################

variable "influx-token" {}
variable "influx-token-in-header" {}
variable "influx-password" {}


# provision datasource
resource "grafana_data_source" "play-ds-influx-flux" {
  provider = grafana.play

  type          = "influxdb"
  name          = "InfluxDB v2 + Flux"
  url           = "https://influx.grafana.fun"
  uid           = "play-influx-2-flux"
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

# provision datasource
resource "grafana_data_source" "play-ds-influx-influxql" {
  provider = grafana.play

  type          = "influxdb"
  name          = "InfluxDB v2 + InfluxQL"
  basic_auth_enabled = false
  basic_auth_username = "grafana"
  url           = "https://influx.grafana.fun"
  uid           = "play-influx-2-influxql"
  username      = "grafana"
  json_data_encoded = jsonencode({
    dbName          = "grafana",
    httpHeaderName1 = "Authorization" 
    httpMode        = "GET", 
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.influx-password}"
    httpHeaderValue1  = "${var.influx-token-in-header}"
  })
}


# output "play_ds_influx-flux" {
#   sensitive = true
#   value = resource.grafana_data_source.play-ds-influx-flux
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-01" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-noaa-buoys.json")
  folder = grafana_folder.play-grafana.id
}

output "play_dashboard_influx_01" {
  value = resource.grafana_dashboard.play-dashboard-influx-01
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-02" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-usgs-earthquakes.json")
  folder = grafana_folder.play-grafana.id
}
output "play_dashboard_influx_02" {
  value = resource.grafana_dashboard.play-dashboard-influx-02
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-03" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-water-samples.json")
  folder = grafana_folder.play-grafana.id
}
output "play_dashboard_influx_03" {
  value = resource.grafana_dashboard.play-dashboard-influx-03
}
# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-04" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-internal-metrics.json")
  folder = grafana_folder.play-grafana.id
}
output "play_dashboard_influx_04" {
  value = resource.grafana_dashboard.play-dashboard-influx-04
}