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
  url           = "https://elastic.grafana.fun"
  uid           = "play-elastic-ecommerce"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "order_date"
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
  url           = "https://elastic.grafana.fun"
  uid           = "play-elastic-flights"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "timestamp"
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
  url           = "https://elastic.grafana.fun"
  uid           = "play-elastic-web-logs"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "timestamp"
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.elastic-password}"
  })
}

resource "grafana_data_source" "play-ds-elastic-04" {
  provider = grafana.play
  
  basic_auth_enabled = true
  basic_auth_username = "elastic"
  database_name = "metrics-*"  
  name          = "play-elastic-metrics"
  type          = "elasticsearch"
  url           = "https://elastic.grafana.fun"
  uid           = "play-elastic-metrics"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "@timestamp"
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = "${var.elastic-password}"
  })
}

resource "grafana_data_source" "play-ds-elastic-05" {
  provider = grafana.play
  
  basic_auth_enabled = true
  basic_auth_username = "elastic"
  database_name = "logs-*"  
  name          = "play-elastic-logs"
  type          = "elasticsearch"
  url           = "https://elastic.grafana.fun"
  uid           = "play-elastic-logs"
  json_data_encoded = jsonencode({
    esVersion                  = "8.0.0"
    includeFrozen              = false
    logLevelField              = ""
    logMessageField            = ""
    maxConcurrentShardRequests = 5
    timeField                  = "@timestamp"
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

  config_json = file("dashboards/play-elastic-ecommerce/ecommerce.json")
  folder = grafana_folder.play-grafana.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-elastic-02" {
  provider = grafana.play

  config_json = file("dashboards/play-elastic-flights/flights.json")
  folder = grafana_folder.play-grafana.id
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-elastic-03" {
  provider = grafana.play

  config_json = file("dashboards/play-elastic-web-logs/logs.json")
  folder = grafana_folder.play-grafana.id
}

output "play_dashboard_elastic_03" {
  value = resource.grafana_dashboard.play-dashboard-elastic-03
}

output "play_dashboard_elastic_01" {
  value = resource.grafana_dashboard.play-dashboard-elastic-01
}

output "play_dashboard_elastic_02" {
  value = resource.grafana_dashboard.play-dashboard-elastic-02
}
