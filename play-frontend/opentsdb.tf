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
  uid                 = "c094061b-de6c-4cc3-b601-f0c4735e0084"
}

# # provision folder
# resource "grafana_folder" "play-folder-elastic" {
#   provider = grafana.play
#   uid   = "play-grafana-elasticsearch"
#   title = "play-grafana-elasticsearch"
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-opentsdb-01" {
  provider = grafana.play

  config_json = file("dashboards/opentsdb/load-graphs.json")
  folder = grafana_folder.play-grafana.id
}
