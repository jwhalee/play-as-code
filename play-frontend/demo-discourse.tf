##################################################
##                                              ##
## DISCOURSE datasource, folder, and dashboards ##
##                                              ## 
##################################################


# provision datasource
resource "grafana_data_source" "play-ds-discourse" {
  provider = grafana.play

  type                = "grafana-discourse-datasource"
  name                = "Grafana Community Forum"
  basic_auth_enabled  = false
  basic_auth_username = ""
  url                 = "https://community.grafana.com"
  uid                 = "kKO9T574k"
  username            = ""
  json_data_encoded   = jsonencode({
    httpHeaderName1   = "Api-Username" 
    httpHeaderName2   = "Api-Key" 
  })
  secure_json_data_encoded = jsonencode({
    httpHeaderValue1  = "${var.discourse-user}"
    httpHeaderValue2  = "${var.discourse-key}"
  })
}

# # provision folder
# resource "grafana_folder" "play-folder-discourse" {
#   provider = grafana.play
#   uid   = "demo-discourse"
#   title = "Demo: Discourse"
# }
