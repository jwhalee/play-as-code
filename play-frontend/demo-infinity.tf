##################################################
##                                              ##
## INFINITY datasource, folder, and dashboards  ##
##                                              ## 
##################################################

# provision datasource
resource "grafana_data_source" "play-ds-infinity" {
  provider = grafana.play

  type                = "yesoreyeram-infinity-datasource"
  name                = "Grafana Forum Data Explorer"
  basic_auth_enabled  = false
  basic_auth_username = ""
  url                 = ""
  uid                 = "U-QRJ7K4k"
  username            = ""
  json_data_encoded   = jsonencode({
    allowedHosts      = ["https://community.grafana.com"]
    globalQueries     = []
    httpHeaderName1   = "Api-Username" 
    httpHeaderName2   = "Api-Key" 
  })
  secure_json_data_encoded = jsonencode({
    httpHeaderValue1  = "${var.discourse-user}"
    httpHeaderValue2  = "${var.discourse-key}"
  })
}

# provision folder
resource "grafana_folder" "play-folder-infinity" {
  provider = grafana.play
  uid   = "demo-infinity"
  title = "Demo: Inifinity (JSON, CSV, and more)"
}

# # provision dashboard
# resource "grafana_dashboard" "play-dashboard-elastic-01" {
#   provider = grafana.play

#   config_json = file("dashboards/elastic/ecommerce.json")
#   folder = grafana_folder.play-folder-elastic.id
# }
