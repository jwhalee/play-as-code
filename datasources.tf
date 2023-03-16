# influx datasource
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
