#################################################
##                                             ##
## MONGODB datasource, folder, and dashboards  ##
##                                             ## 
#################################################

# provision datasource
resource "grafana_data_source" "play-ds-mongodb-01" {
  provider = grafana.play
  
  basic_auth_enabled  = false
  basic_auth_username = ""
  database_name       = ""
  is_default          = false 
  name                = "MongoDB"
  type                = "grafana-mongodb-datasource"
  url                 = ""
  uid                 = "3t8hjdV4k"
  json_data_encoded = jsonencode({
    connection = "mongodb+srv://christineuser:Zs05bm3S7AFbP1jB@cluster0.wscph.mongodb.net/sample_analytics"
  })
}

# # provision folder
# resource "grafana_folder" "play-folder-elastic" {
#   provider = grafana.play
#   uid   = "play-grafana-elasticsearch"
#   title = "play-grafana-elasticsearch"
# }

# provision dashboard
resource "grafana_dashboard" "play-dashboard-mongodb-01" {
  provider = grafana.play

  config_json = file("dashboards/mongodb/movie-reviews.json")
  folder = grafana_folder.play-grafana.id
}
