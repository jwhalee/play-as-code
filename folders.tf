# influx folder
resource "grafana_folder" "play-folder-influx" {
  provider = grafana.play

  title = "influxDB"
}

# elastic folder
resource "grafana_folder" "play-folder-elastic" {
  provider = grafana.play

  title = "elasticsearch"
}