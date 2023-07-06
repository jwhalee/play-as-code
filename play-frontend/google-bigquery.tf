#################################################
##                                             ##
## BIGQUERY datasource, folder, and dashboards ##
##                                             ## 
#################################################

variable "bigquery-key" {}

# provision datasource
resource "grafana_data_source" "play-ds-bigquery-01" {
  provider = grafana.play
  
  basic_auth_enabled  = false
  basic_auth_username = ""
  database_name       = ""
  is_default          = false 
  name                = "Google BigQuery"
  type                = "grafana-bigquery-datasource"
  url                 = ""
  uid                 = "d30a82c2-6885-4634-afe9-a0dabcda3d0c"
  json_data_encoded = jsonencode({
    authenticationType = "jwt"
    clientEmail        = "play-grafana-net@chris-analytics-testing.iam.gserviceaccount.com"
    defaultProject     = "chris-analytics-testing"
    tokenUri           = "https://oauth2.googleapis.com/token"
  })
  secure_json_data_encoded = jsonencode({
    privateKey = "${var.bigquery-key}"
  })
}

# # provision folder
# resource "grafana_folder" "play-folder-elastic" {
#   provider = grafana.play
#   uid   = "play-grafana-elasticsearch"
#   title = "play-grafana-elasticsearch"
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-bigquery-01" {
  provider = grafana.play

  config_json = file("dashboards/google-bigquery/citibike-usage.json")
  folder = grafana_folder.play-grafana.id
}

resource "grafana_dashboard" "play-dashboard-bigquery-02" {
  provider = grafana.play

  config_json = file("dashboards/google-bigquery/global-life-expectancy.json")
  folder = grafana_folder.play-grafana.id
}