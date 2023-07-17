#################################################
##                                             ##
## OPENTSDB datasource, folder, and dashboards ##
##                                             ## 
#################################################

# provision datasource
resource "grafana_data_source" "play-ds-opentsdb-01" {
  provider = grafana.play
  
  basic_auth_enabled  = false
  basic_auth_username = ""
  database_name       = ""
  is_default          = false 
  name                = "opentsdb"
  type                = "opentsdb"
  url                 = "https://opentsdb.grafana.fun"
  uid                 = "play-opentsdb"
}

# provision folder
resource "grafana_folder" "play-folder-opentsdb" {
  provider = grafana.play
  uid   = "demo-opentsdb"
  title = "Demo: OpenTSDB"
}

# provision dashboard
resource "grafana_dashboard" "play-dashboard-opentsdb-01" {
  provider = grafana.play

  config_json = file("dashboards/opentsdb/load-graphs.json")
  folder = grafana_folder.play-folder-opentsdb.id
}
