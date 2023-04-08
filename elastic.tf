################################################
##                                            ##
## ELASTIC datasource, folder, and dashboards ##
##                                            ## 
################################################

variable "elastic-password" {}

# provision datasource
resource "grafana_data_source" "play-ds-elastic-01" {
  provider = grafana.play
  
  basic_auth_enabled = true
  basic_auth_username = "elastic"
  database_name = "kibana_sample_data_ecommerce"  
  name          = "play-elastic-ecommerce"
  type          = "elasticsearch"
  url           = "https://34.72.102.97:9200"
  uid           = "play-elastic-ecommerce"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "order_date"
    tlsSkipVerify              = true
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.elastic-password}"
  })
}

resource "grafana_data_source" "play-ds-elastic-02" {
  provider = grafana.play
  
  basic_auth_enabled = true
  basic_auth_username = "elastic"
  database_name = "kibana_sample_data_flights"  
  name          = "play-elastic-flights"
  type          = "elasticsearch"
  url           = "https://34.72.102.97:9200"
  uid           = "play-elastic-flights"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "timestamp"
    tlsSkipVerify              = true
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.elastic-password}"
  })
}

resource "grafana_data_source" "play-ds-elastic-03" {
  provider = grafana.play
  
  basic_auth_enabled = true
  basic_auth_username = "elastic"
  database_name = "kibana_sample_data_logs"  
  name          = "play-elastic-web-logs"
  type          = "elasticsearch"
  url           = "https://34.72.102.97:9200"
  uid           = "play-elastic-web-logs"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "timestamp"
    tlsSkipVerify              = true
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.elastic-password}"
  })
}

# # provision folder
# resource "grafana_folder" "play-folder-elastic" {
#   provider = grafana.play
#   uid   = "play-grafana-elasticsearch"
#   title = "play-grafana-elasticsearch"
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-elastic-01" {
  provider = grafana.play

  config_json = file("dashboards/elastic/elastic-ecommerce-data.json")
  folder = grafana_folder.play-grafana.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-elastic-02" {
  provider = grafana.play

  config_json = file("dashboards/elastic/elastic-flight-data.json")
  folder = grafana_folder.play-grafana.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-elastic-03" {
  provider = grafana.play

  config_json = file("dashboards/elastic/elastic-web-logs.json")
  folder = grafana_folder.play-grafana.id
}
