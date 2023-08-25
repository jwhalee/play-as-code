#################################################
##                                             ##
## SHEETS datasource, folder, and dashboards   ##
##                                             ## 
#################################################

# provision datasource
resource "grafana_data_source" "play-ds-sheets-01" {
  provider = grafana.play

  basic_auth_enabled  = false
  basic_auth_username = ""
  database_name       = ""
  is_default          = false
  name                = "Google Sheets"
  type                = "grafana-googlesheets-datasource"
  url                 = ""
  uid                 = "000000122"
  json_data_encoded = jsonencode({
    authenticationType = "key"
    authType           = "key"
  })
  secure_json_data_encoded = jsonencode({
    apiKey = "${var.sheets-key}"
  })
}

# provision folder
# resource "grafana_folder" "play-folder-bigquery" {
#   provider = grafana.play
#   uid      = "demo-bigquery"
#   title    = "Demo: BigQuery"
# }

# provision dashboards
# resource "grafana_dashboard" "play-dashboard-bigquery-01" {
#   provider = grafana.play

#   config_json = file("dashboards/google-bigquery/citibike-usage.json")
#   folder      = grafana_folder.play-folder-bigquery.id
# }

# resource "grafana_dashboard" "play-dashboard-bigquery-02" {
#   provider = grafana.play

#   config_json = file("dashboards/google-bigquery/global-life-expectancy.json")
#   folder      = grafana_folder.play-folder-bigquery.id
# }