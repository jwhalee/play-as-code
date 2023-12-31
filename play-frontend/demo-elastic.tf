################################################
##                                            ##
## ELASTIC datasource, folder, and dashboards ##
##                                            ## 
################################################

# provision datasource
resource "grafana_data_source" "play-ds-elastic-01" {
  provider = grafana.play

  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  database_name       = "kibana_sample_data_ecommerce"
  name                = "Elasticsearch: E-commerce data"
  type                = "elasticsearch"
  url                 = "https://elastic.grafana.fun"
  uid                 = "play-elastic-ecommerce"
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

  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  database_name       = "kibana_sample_data_flights"
  name                = "Elasticsearch: Flight data"
  type                = "elasticsearch"
  url                 = "https://elastic.grafana.fun"
  uid                 = "play-elastic-flights"
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

  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  database_name       = "kibana_sample_data_logs"
  name                = "Elasticsearch: Sample logs"
  type                = "elasticsearch"
  url                 = "https://elastic.grafana.fun"
  uid                 = "play-elastic-web-logs"
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

resource "grafana_data_source" "play-ds-elastic-04" {
  provider = grafana.play

  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  database_name       = "metrics-*"
  name                = "Elasticsearch: K8s metrics"
  type                = "elasticsearch"
  url                 = "https://elastic.grafana.fun"
  uid                 = "play-elastic-metrics"
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

  basic_auth_enabled  = true
  basic_auth_username = "elastic"
  database_name       = "logs-*"
  name                = "Elasticsearch: K8s logs"
  type                = "elasticsearch"
  url                 = "https://elastic.grafana.fun"
  uid                 = "play-elastic-logs"
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

# provision folder
resource "grafana_folder" "play-folder-elastic" {
  provider = grafana.play
  uid      = "demo-elasticsearch"
  title    = "Demo: Elasticsearch"
}

# provision dashbaords
resource "grafana_dashboard" "elastic" {
  provider = grafana.play

  for_each    = fileset("${path.module}/dashboards/elastic", "*.json")
  config_json = file("${path.module}/dashboards/elastic/${each.key}")
  folder      = grafana_folder.play-folder-elastic.id
}
