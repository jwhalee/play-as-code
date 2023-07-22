###############################################
##                                           ##
## INFLUX datasource, folder, and dashboards ##
##                                           ## 
###############################################


# provision datasource
resource "grafana_data_source" "play-ds-influx-flux" {
  provider = grafana.play

  type = "influxdb"
  name = "InfluxDB v2 + Flux"
  url  = "https://influx.grafana.fun"
  uid  = "play-influx-2-flux"
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

  type                = "influxdb"
  name                = "InfluxDB v2 + InfluxQL"
  basic_auth_enabled  = false
  basic_auth_username = "grafana"
  url                 = "https://influx.grafana.fun"
  uid                 = "play-influx-2-influxql"
  username            = "grafana"
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

# provision folder
resource "grafana_folder" "play-folder-influx" {
  provider = grafana.play
  uid      = "demo-influxdb2"
  title    = "Demo: InfluxDB 2"
}

# provision dashbaords
resource "grafana_dashboard" "influx" {
  provider = grafana.play

  for_each    = fileset("${path.module}/dashboards/influx", "*.json")
  config_json = file("${path.module}/dashboards/influx/${each.key}")
  folder      = grafana_folder.play-folder-influx.id
}