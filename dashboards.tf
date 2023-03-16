##############
##          ##
##  INFLUX  ##
##          ## 
##############

# influx
resource "grafana_dashboard" "play-dashboard-influx-01" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-noaa-buoys.json")
  folder = grafana_folder.play-folder-influx.id
}

# influx
resource "grafana_dashboard" "play-dashboard-influx-02" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-usgs-earthquakes.json")
  folder = grafana_folder.play-folder-influx.id
}

# influx
resource "grafana_dashboard" "play-dashboard-influx-03" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-water-samples.json")
  folder = grafana_folder.play-folder-influx.id
}

# influx
resource "grafana_dashboard" "play-dashboard-influx-04" {
  provider = grafana.play

  config_json = file("dashboards/influx/influx-internal-metrics.json")
  folder = grafana_folder.play-folder-influx.id
}

###############
##           ##
##  ELASTIC  ##
##           ## 
###############

# influx
resource "grafana_dashboard" "play-dashboard-elastic-01" {
  provider = grafana.play

  config_json = file("dashboards/elastic/TK.json")
  folder = grafana_folder.play-folder-elastic.id
}