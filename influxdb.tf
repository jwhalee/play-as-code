####################################################################
##                                                                ##
## STEP 3: provision datasources, folders, and dashbaords         ##
##                                                                ## 
####################################################################


###############################################
##                                           ##
## INFLUX datasource, folder, and dashboards ##
##                                           ## 
###############################################

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
    token = "-UGPBXzFUWtwa7M2JD5b8iuA8pVInwH7ms-fBofSa52ddESlvg_oqKohn60x5-sF-OgvWa5BKFpUu8BgY5auGQ=="
  })
}

# provision folder
resource "grafana_folder" "play-folder-influx" {
  provider = grafana.play

  title = "influxDB"
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-01" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-noaa-buoys.json")
  folder = grafana_folder.play-folder-influx.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-02" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-usgs-earthquakes.json")
  folder = grafana_folder.play-folder-influx.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-03" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-water-samples.json")
  folder = grafana_folder.play-folder-influx.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-influx-04" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-internal-metrics.json")
  folder = grafana_folder.play-folder-influx.id
}